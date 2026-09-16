#!/usr/bin/env python3
"""Renderiza os templates de tema com uma paleta e recarrega os apps.

Uso:  theme <nome-da-paleta>
      theme --list

Cada template em themes/templates/ vira um arquivo dentro do pacote stow
correspondente. Como o stow ja fez o symlink pra ~/.config, o app enxerga
o arquivo novo na hora.
"""
import argparse
import json
import shutil
import os
import re
import subprocess
import sys
sys.dont_write_bytecode = True
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PALETTES = ROOT / "themes" / "palettes"
TEMPLATES = ROOT / "themes" / "templates"
STATE = ROOT / "themes" / ".current"

# template -> (owning package, path inside the package)
TARGETS = {
    "hyprland/waybar-style.css.tmpl": ("desktops/hyprland/waybar", ".config/waybar/style.css"),
    "hyprland/waybar-config.jsonc.tmpl": ("desktops/hyprland/waybar", ".config/waybar/config.jsonc"),
    "hyprland/rofi-theme.rasi.tmpl": ("desktops/hyprland/rofi", ".config/rofi/theme.rasi"),
    "hyprland/rofi-grid.rasi.tmpl": ("desktops/hyprland/rofi", ".config/rofi/grid.rasi"),
    "hyprland/mako-config.tmpl": ("desktops/hyprland/mako", ".config/mako/config"),
    "hyprland/dock-style.css.tmpl": ("desktops/hyprland/dock", ".config/nwg-dock-hyprland/style.css"),
    "hyprland/dock-launcher.svg.tmpl": ("desktops/hyprland/dock", "@themes/dock/launcher.svg"),
    "common/ghostty-theme.tmpl": ("common/ghostty", ".config/ghostty/themes/current"),
    "linux/gtk.css.tmpl": ("linux/gtk", ".config/gtk-3.0/gtk.css"),
    "hyprland/hypr-colors.lua.tmpl": ("desktops/hyprland/compositor", ".config/hypr/colors.lua"),
    "common/btop.theme.tmpl": ("common/btop", ".config/btop/themes/current.theme"),
    "common/yazi-theme.toml.tmpl": ("common/yazi", ".config/yazi/theme.toml"),
    "common/kitty-theme.conf.tmpl": ("common/kitty", ".config/kitty/theme.conf"),
    "hyprland/sddm-main.qml.tmpl": ("desktops/hyprland/compositor", "@themes/sddm/Main.qml"),
}


def load_palette(name):
    path = PALETTES / f"{name}.toml"
    if not path.exists():
        sys.exit(f"paleta '{name}' nao existe em {PALETTES}")
    with open(path, "rb") as f:
        data = tomllib.load(f)
    vars_ = {}
    vars_.update(data.get("colors", {}))
    vars_.update(data.get("opts", {}))
    # Para cada cor #rrggbb gera variantes derivadas:
    #   _raw   "120,169,255"  -> hyprland usa rgb(r,g,b)
    #   _hex   "78a9ff"       -> sem o #
    #   _dark  50% mais escura -> sombra do efeito 3D (borda de baixo)
    #   _dim   75% mais escura -> estados apagados
    def escurecer(val, fator):
        r, g, b = (int(val[i:i + 2], 16) for i in (1, 3, 5))
        return "#%02x%02x%02x" % (int(r * fator), int(g * fator), int(b * fator))

    for key, val in list(vars_.items()):
        if isinstance(val, str) and re.fullmatch(r"#[0-9a-fA-F]{6}", val):
            r, g, b = (int(val[i:i + 2], 16) for i in (1, 3, 5))
            vars_[f"{key}_raw"] = f"{r},{g},{b}"
            vars_[f"{key}_hex"] = val.lstrip("#")
            for suf, fator in (("dark", 0.50), ("dim", 0.75)):
                d = escurecer(val, fator)
                vars_[f"{key}_{suf}"] = d
                # derivadas tambem ganham _raw: templates precisam delas em
                # rgba(...) quando a cor entra com transparencia.
                dr, dg, db = (int(d[i:i + 2], 16) for i in (1, 3, 5))
                vars_[f"{key}_{suf}_raw"] = f"{dr},{dg},{db}"
    return data.get("name", name), vars_


def render(text, vars_, tmpl_name):
    missing = set()

    def sub(m):
        key = m.group(1).strip()
        if key not in vars_:
            missing.add(key)
            return m.group(0)
        return str(vars_[key])

    out = re.sub(r"\{\{([a-z0-9_]+)\}\}", sub, text)
    if missing:
        sys.exit(f"{tmpl_name}: chave(s) ausente(s) na paleta: {', '.join(sorted(missing))}")
    return out


def reload_apps(packages):
    if sys.platform != "linux" or not os.environ.get("HYPRLAND_INSTANCE_SIGNATURE"):
        return
    steps = [
        ("desktops/hyprland/waybar", ["systemctl", "--user", "reload-or-restart", "waybar.service"]),
        ("desktops/hyprland/mako", ["makoctl", "reload"]),
        ("desktops/hyprland/compositor", ["hyprctl", "reload"]),
        ("desktops/hyprland/dock", ["systemctl", "--user", "restart", "nwg-dock.service"]),
    ]
    for package, cmd in steps:
        if package in packages and shutil.which(cmd[0]):
            result = subprocess.run(cmd, capture_output=True, text=True)
            print(f"  {package}: {'ok' if result.returncode == 0 else result.stderr.strip()}")
    if "desktops/hyprland/compositor" in packages:
        print("  SDDM: use sddm-install para atualizar o tema de login, se necessario.")


def planned_outputs(packages, palette):
    _, vars_ = load_palette(palette)
    outputs = []
    for tmpl, (package, dest) in TARGETS.items():
        if package not in packages:
            continue
        out = render((TEMPLATES / tmpl).read_text(), vars_, tmpl)
        path = ROOT / dest[1:] if dest.startswith("@") else ROOT / "packages" / package / dest
        outputs.append((path, out))
        if dest == ".config/gtk-3.0/gtk.css":
            outputs.append((ROOT / "packages" / package / ".config/gtk-4.0/gtk.css", out))
    return outputs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("palette", nargs="?")
    parser.add_argument("--list", action="store_true")
    parser.add_argument("--profile")
    parser.add_argument("--no-reload", action="store_true")
    parser.add_argument("--check", action="store_true", help="Validate without writing or reloading")
    args = parser.parse_args()
    if args.list:
        cur = STATE.read_text().strip() if STATE.exists() else None
        for p in sorted(PALETTES.glob("*.toml")):
            print(f"  {p.stem}{' *' if p.stem == cur else ''}")
        return
    if not args.palette:
        parser.error("provide a palette or --list")
    sys.path.insert(0, str(ROOT / "scripts"))
    from profiles import packages_for
    if args.profile:
        packages = packages_for(args.profile)
    else:
        state = Path.home() / ".local/state/dotfiles/install.json"
        if not state.exists():
            parser.error("run install.sh --profile NAME first or pass --profile NAME")
        packages = json.loads(state.read_text())["packages"]
    outputs = planned_outputs(packages, args.palette)
    print(f"tema: {args.palette} ({len(outputs)} arquivos)")
    for path, out in outputs:
        print(f"  -> {path.relative_to(ROOT)}")
        if not args.check:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(out)
    if not args.check:
        STATE.write_text(args.palette + "\n")
        if not args.no_reload:
            reload_apps(packages)


if __name__ == "__main__":
    main()
