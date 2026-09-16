"""Read declarative profiles without executing shell code."""
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

def packages_for(name, stack=()):
    if not name or any(c not in 'abcdefghijklmnopqrstuvwxyz0123456789-' for c in name):
        raise ValueError(f'Invalid profile: {name}')
    if name in stack:
        raise ValueError(f'Profile cycle: {stack + (name,)}')
    packages = []
    for line in (ROOT / 'profiles' / f'{name}.conf').read_text().splitlines():
        line = line.split('#', 1)[0].strip()
        if not line:
            continue
        if line.startswith('@include '):
            entries = packages_for(line.split()[1], stack + (name,))
        else:
            path = ROOT / 'packages' / line
            if '..' in Path(line).parts or Path(line).is_absolute() or not path.is_dir():
                raise ValueError(f'Invalid package: {line}')
            entries = [line]
        packages.extend(p for p in entries if p not in packages)
    return packages
