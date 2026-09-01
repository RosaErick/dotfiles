#!/usr/bin/env python3
"""Renderiza os templates de tema com uma paleta e recarrega os apps.

Uso:  theme <nome-da-paleta>
      theme --list

Cada template em theme/templates/ vira um arquivo dentro do pacote stow
correspondente. Como o stow ja fez o symlink pra ~/.config, o app enxerga
o arquivo novo na hora.
"""
import os
import re
import subprocess
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PALETTES = ROOT / "theme" / "palettes"
TEMPLATES = ROOT / "theme" / "templates"
STATE = ROOT / "theme" / ".current"

# template -> destino, relativo a ROOT (dentro do pacote stow)
TARGETS = {
    "waybar-style.css.tmpl":  ".config/waybar/style.css",
    "waybar-config.jsonc.tmpl": ".config/waybar/config.jsonc",
    "rofi-theme.rasi.tmpl":   ".config/rofi/theme.rasi",
    "rofi-grid.rasi.tmpl":    ".config/rofi/grid.rasi",
    "mako-config.tmpl":       ".config/mako/config",
    "dock-style.css.tmpl":    ".config/nwg-dock-hyprland/style.css",
    "ghostty-theme.tmpl":     ".config/ghostty/themes/current",
    "gtk.css.tmpl":           ".config/gtk-3.0/gtk.css",
    "hypr-colors.lua.tmpl":   ".config/hypr/colors.lua",
    "btop.theme.tmpl":        ".config/btop/themes/current.theme",
    "yazi-theme.toml.tmpl":   ".config/yazi/theme.toml",
    "kitty-theme.conf.tmpl":  ".config/kitty/theme.conf",
    "sddm-main.qml.tmpl":     "theme/sddm/Main.qml",
}

# gtk-4.0 recebe copia identica do gtk-3.0
EXTRA_COPIES = {
    ".config/gtk-3.0/gtk.css": [".config/gtk-4.0/gtk.css"],
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


def reload_apps():
    steps = [
        ("waybar",   ["systemctl", "--user", "reload-or-restart", "waybar.service"]),
        ("mako",     ["makoctl", "reload"]),
        ("hyprland", ["hyprctl", "reload"]),
    ]
    for label, cmd in steps:
        r = subprocess.run(cmd, capture_output=True, text=True)
        print(f"  {label}: {'ok' if r.returncode == 0 else 'FALHOU — ' + r.stderr.strip()[:60]}")
    # dock nao recarrega CSS a quente: reinicia pelo systemd.
    # Os flags moram so em .scripts/dock — nao duplicar aqui.
    r = subprocess.run(["systemctl", "--user", "restart", "nwg-dock.service"],
                       capture_output=True, text=True)
    print(f"  dock: {'ok' if r.returncode == 0 else 'FALHOU — ' + r.stderr.strip()[:60]}")
    print("  ghostty/rofi: releem sozinhos na proxima janela")
    # A tela de login vive em /usr/share e so root escreve la, entao ela nao
    # acompanha a troca de tema. Ficar defasada e silencioso: o SDDM cai no
    # tema embutido no proximo boot e voce so descobre no login. Avisa.
    inst = Path("/usr/share/sddm/themes/carbonfox/Main.qml")
    novo_qml = ROOT / "theme/sddm/Main.qml"
    if novo_qml.exists():
        try:
            atual = inst.read_text() if inst.exists() else None
        except OSError:
            atual = None
        if atual != novo_qml.read_text():
            print("  login: DEFASADO — rode 'sddm-install' (precisa de sudo)")
        else:
            print("  login: ok")


def main():
    args = sys.argv[1:]
    if not args or args[0] in ("-h", "--help"):
        print(__doc__)
        return
    if args[0] == "--list":
        cur = STATE.read_text().strip() if STATE.exists() else None
        for p in sorted(PALETTES.glob("*.toml")):
            mark = " *" if p.stem == cur else ""
            print(f"  {p.stem}{mark}")
        return

    name, vars_ = load_palette(args[0])
    print(f"tema: {name}")
    for tmpl, dest in TARGETS.items():
        src = TEMPLATES / tmpl
        if not src.exists():
            sys.exit(f"template ausente: {src}")
        out = render(src.read_text(), vars_, tmpl)
        dpath = ROOT / dest
        dpath.parent.mkdir(parents=True, exist_ok=True)
        dpath.write_text(out)
        print(f"  -> {dest}")
        for extra in EXTRA_COPIES.get(dest, []):
            epath = ROOT / extra
            epath.parent.mkdir(parents=True, exist_ok=True)
            epath.write_text(out)
            print(f"  -> {extra}")

    STATE.write_text(args[0] + "\n")
    print("recarregando:")
    reload_apps()


if __name__ == "__main__":
    main()
