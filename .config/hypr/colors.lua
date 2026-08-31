-- GERADO por `theme` — edite theme/templates/hypr-colors.lua.tmpl
-- Carregado pelo hyprland.lua via require("colors")
--
-- Gradiente accent -> magenta a 45 graus: fica em tom com a paleta sem virar
-- um retangulo chapado. Inativa quase invisivel, so marca o limite.
--
-- ATENCAO: gradiente em lua e uma TABELA { colors = {...}, angle = n },
-- nao a string "rgba(..) rgba(..) 45deg" do formato .conf.
hl.config({
    general = {
        col = {
            active_border   = { colors = { "rgba(278bd3ff)", "rgba(d33682ff)" }, angle = 45 },
            inactive_border = "rgba(073541cc)",
        },
    },
})
