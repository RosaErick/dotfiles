# Temas

`themes/palettes/` guarda as cores; `themes/templates/` separa templates
compartilhados, Linux e Hyprland. `themes/render.py` gera os arquivos nos
pacotes correspondentes. Edite os templates, não as saídas ignoradas pelo Git.

```sh
theme --list
theme carbonfox
theme solarized-dark-patched --no-reload
```

O comando usa os pacotes registrados pelo instalador. No perfil macOS,
por exemplo, não gera Waybar nem tenta executar systemctl. A recarga do
desktop só ocorre em Linux, numa sessão Hyprland, para os pacotes selecionados.

Para validar outra combinação sem escrever arquivos:

```sh
python3 themes/render.py carbonfox --profile macos --check
```

Os perfis são aditivos; `theme` considera todos os pacotes registrados.
A paleta atual fica em `themes/.current`, fora do Git. Fish, tmux e o tema
do editor mantêm suas configurações próprias.

Para uma nova paleta, copie um TOML e altere as cores. O renderizador calcula
as variantes escuras e os formatos RGB/hex usados pelos templates.
O SDDM só recebe uma atualização quando você executa `sddm-install`.
