return {
  {
    -- O LazyVim ja fornece este motor e as fontes LSP, path, snippets e buffer.
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        -- Tab percorre sugestoes; fora do menu, preserva snippets e futuras IAs.
        ["<Tab>"] = {
          "select_next",
          LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        menu = { auto_show = true, border = "rounded" },
        -- Enter so aceita depois de selecionar uma sugestao.
        list = { selection = { preselect = false, auto_insert = false } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },
      },
    },
  },
}
