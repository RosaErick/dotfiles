#!/usr/bin/env python3
"""Link selected packages. Dependency installation and service activation are separate."""
import argparse
import json
import shutil
import subprocess
import sys
from pathlib import Path
sys.dont_write_bytecode = True
from profiles import ROOT, packages_for


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile', required=True)
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--target', type=Path, default=Path.home())
    parser.add_argument('--theme', default=None)
    args = parser.parse_args()
    packages = packages_for(args.profile)
    target = args.target.expanduser().resolve()
    if not target.is_dir():
        parser.error('--target must be an existing directory')
    if not shutil.which('stow'):
        parser.error('Install GNU Stow first')
    state = target / '.local/state/dotfiles/install.json'
    old = json.loads(state.read_text()) if state.exists() else {}
    current = ROOT / 'themes/.current'
    palette = args.theme or (current.read_text().strip() if current.exists() else old.get('theme', 'carbonfox'))
    print(f'Profile: {args.profile}; target: {target}', flush=True)
    sys.path.insert(0, str(ROOT / 'themes'))
    from render import planned_outputs
    outputs = planned_outputs(packages, palette)
    # Generated-only files may not exist in a fresh checkout yet, so Stow
    # cannot detect their conflicts until rendering. Check them beforehand.
    for source, _ in outputs:
        for package in packages:
            base = ROOT / 'packages' / package
            if source.is_relative_to(base):
                destination = target / source.relative_to(base)
                if destination.exists() or destination.is_symlink():
                    if destination.resolve() != source.resolve():
                        raise ValueError(f'Conflict: {destination}; preserve or back it up before installing')
                for parent in destination.parents:
                    if parent == target:
                        break
                    if parent.exists() and not parent.is_dir():
                        raise ValueError(f'Not a directory: {parent}')
    commands = []
    for package in packages:
        path = ROOT / 'packages' / package
        cmd = ['stow', '--no-folding', '--dir', str(path.parent), '--target', str(target), '--restow', path.name]
        commands.append(cmd)
        subprocess.run(cmd + ['--simulate'], check=True)
    if args.dry_run:
        print('Dry run complete; no files or services changed.')
        return
    render = [sys.executable, '-B', str(ROOT / 'themes/render.py'), palette,
              '--profile', args.profile, '--no-reload']
    subprocess.run(render, check=True)
    for cmd in commands:
        subprocess.run(cmd, check=True)
    state.parent.mkdir(parents=True, exist_ok=True)
    # Profiles are additive; switching never deletes previously installed packages.
    installed = list(dict.fromkeys(old.get('packages', []) + packages))
    state.write_text(json.dumps({'profile': args.profile, 'packages': installed, 'theme': palette}, indent=2) + '\n')
    print('Links installed. See docs/installation.md for plugins and optional services.')

if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, subprocess.CalledProcessError) as exc:
        raise SystemExit(str(exc))
