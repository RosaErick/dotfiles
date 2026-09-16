"""Exercise a fresh checkout and disposable homes, never the real user's links."""
import json
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name)
        self.repo = self.base / 'dotfiles'
        self.home = self.base / 'home'
        self.home.mkdir()
        # Include pending changes, exclude generated and host-specific files.
        paths = subprocess.check_output(
            ['git', 'ls-files', '-co', '--exclude-standard', '-z'], cwd=ROOT
        ).decode().split('\0')
        for name in set(paths) - {''}:
            src = ROOT / name
            if src.is_file():
                dst = self.repo / name
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src, dst)

    def install(self, profile, *args, success=True):
        result = subprocess.run(
            ['sh', str(self.repo / 'install.sh'), '--profile', profile,
             '--target', str(self.home), *args], capture_output=True, text=True
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0)
        return result

    def test_fresh_profiles_and_reapplication(self):
        for profile in ['cli', 'macos', 'linux-desktop', 'arch-hyprland']:
            with self.subTest(profile=profile):
                self.install(profile)
                self.install(profile)
                self.assertTrue((self.home / '.config/fish/conf.d/tide.fish').is_symlink())
                self.assertTrue((self.home / '.config/nvim/init.lua').is_file())
                self.assertTrue((self.home / '.config/yazi/theme.toml').is_file())
                if profile in ['cli', 'macos']:
                    self.assertFalse((self.home / '.config/hypr').exists())
                    self.assertFalse((self.home / '.config/systemd').exists())
                    self.assertFalse((self.home / '.config/gtk-3.0').exists())
                if profile == 'cli':
                    self.assertFalse((self.home / '.config/ghostty').exists())
                if profile == 'arch-hyprland':
                    self.assertTrue((self.home / '.config/waybar/config.jsonc').is_file())
                for p in self.home.rglob('*'):
                    if p.is_symlink():
                        self.assertTrue(p.exists(), str(p))

    def test_dry_run_writes_nothing(self):
        before = {p.relative_to(self.repo): p.read_bytes() for p in self.repo.rglob('*') if p.is_file()}
        self.install('arch-hyprland', '--dry-run')
        after = {p.relative_to(self.repo): p.read_bytes() for p in self.repo.rglob('*') if p.is_file()}
        self.assertEqual(before, after)
        self.assertEqual(list(self.home.iterdir()), [])

    def test_conflict_preserves_user_file_and_creates_no_links(self):
        target = self.home / '.config/fish/config.fish'
        target.parent.mkdir(parents=True)
        target.write_text('# personal config\n')
        self.install('cli', success=False)
        self.assertEqual(target.read_text(), '# personal config\n')
        self.assertFalse((self.home / '.zshrc').exists())
        self.assertFalse((self.home / '.local/state/dotfiles/install.json').exists())

    def test_runtime_files_survive_reinstall(self):
        self.install('cli')
        local = self.home / '.config/fish/local.fish'
        local.write_text('# local\n')
        self.install('cli')
        self.assertEqual(local.read_text(), '# local\n')
        self.assertFalse((self.repo / 'packages/common/fish/.config/fish/local.fish').exists())

    def test_generated_file_conflict_is_detected_in_dry_run(self):
        target = self.home / '.config/waybar/style.css'
        target.parent.mkdir(parents=True)
        target.write_text('/* personal theme */\n')
        self.install('arch-hyprland', '--dry-run', success=False)
        self.assertEqual(target.read_text(), '/* personal theme */\n')
        self.assertFalse((self.home / '.zshrc').exists())

    def test_invalid_profile_rejected(self):
        self.install('../README', success=False)
        self.assertEqual(list(self.home.iterdir()), [])


if __name__ == '__main__':
    unittest.main()
