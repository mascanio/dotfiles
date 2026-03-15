-- blink.cmp configuration
-- https://cmp.saghen.dev/

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<CR>"]    = { "accept", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

-- Pass blink capabilities to every LSP via the new vim.lsp.config API

})

-- Expose blink capabilities so lsp/init.lua can pick them up
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- GoLang LSP extra settings (capabilities already set via vim.lsp.config("*", ...) above)
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
})
