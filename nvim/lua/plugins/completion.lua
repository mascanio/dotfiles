return {
  "saghen/blink.cmp",
  version = "1.*",
  build = 'cargo build --release',
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saghen/blink.compat",
  },

  opts = {
    keymap = {
      preset      = "default",
      ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ['<C-k>']   = { 'select_prev', 'fallback_to_mappings' },
      ['<C-j>']   = { 'select_next', 'fallback_to_mappings' },
      ['<C-h>']   = { 'show_signature', 'hide_signature', 'fallback' },

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
      capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      }),
    })
  end,
}
