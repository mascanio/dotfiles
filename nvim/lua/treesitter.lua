-- TREESITTER
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
require('nvim-treesitter').install({
  "bash",
  "c",
  "diff",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "python",
  "regex",
  "rust",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}):wait(300000) -- wait max. 5 minutes

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    '*.sh',
    '*.c', '*.h',
    '*.go',
    '*.htm', '*.html',
    '*.js',
    '*.json',
    '*.lua',
    '*.md',
    '*.py',
    '*.toml',
    '*.xml',
    '*.yml', '*.yaml',
  },
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
