# Themes

`themes/palettes/` stores colors; `themes/templates/` separates shared, Linux,
and Hyprland templates. `themes/render.py` generates files in the corresponding
packages. Edit the templates, not the outputs ignored by Git.

```sh
theme --list
theme carbonfox
theme solarized-dark-patched --no-reload
```

The command uses the packages registered by the installer. In the macOS
profile, for example, it does not generate Waybar files or try to run systemctl.
Desktop reloading only happens on Linux, in a Hyprland session, for the selected
packages.

To validate another combination without writing files:

```sh
python3 themes/render.py carbonfox --profile macos --check
```

Profiles are additive; `theme` considers all registered packages.
The current palette is stored in `themes/.current`, outside Git. Fish, tmux,
and the editor theme keep their own configurations.

For a new palette, copy a TOML file and change the colors. The renderer computes
the darker variants and RGB/hex formats used by the templates.
SDDM is only updated when you run `sddm-install`.
