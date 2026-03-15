return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
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
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end,
}
