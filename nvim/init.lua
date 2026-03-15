local o = vim.opt
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.wrap = false
o.autoread = true
o.list = true
o.signcolumn = "yes"
o.backspace = "indent,eol,start"
o.shell = "/bin/bash"
o.colorcolumn = "100"
o.completeopt = { "menuone", "noselect", "popup" }
o.wildmode = { "lastused", "full" }
o.pumheight = 15
o.laststatus = 0
o.winborder = "rounded"
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.swapfile = false
o.foldmethod = "indent"
o.foldlevelstart = 99
o.relativenumber = true
o.number = true
o.termguicolors = true

local g = vim.g
g.mapleader = " "
g.maplocalleader = " "

local opts = { silent = true }
local map = vim.keymap.set
map("t", "<Esc>", [[<C-\><C-n>]], opts) -- exit terminal mode
map("n", "<leader>t", "<cmd>term zsh<cr>", opts)

map("n", "Q", "<nop>", opts) -- disable "Q"

map("n", "<C-k>", "<cmd>wincmd k<cr>", opts) -- navigate splits
map("n", "<C-j>", "<cmd>wincmd j<cr>", opts)
map("n", "<C-h>", "<cmd>wincmd h<cr>", opts)
map("n", "<C-l>", "<cmd>wincmd l<cr>", opts)

map("n", "<leader>q", "<cmd>bd!<cr>", opts)
map("n", "<leader>b", ":b ")

map({ "n", "v" }, "<leader>u", "<cmd>GitLink<cr>", opts)
map("n", "<leader>d", ":DiffviewOpen ")

map("n", "<leader>e", vim.diagnostic.open_float, opts)
map("n", "<leader>y", function() -- copy relative filepath to clipboard
  vim.fn.setreg("+", vim.fn.expand("%"))
end)

map("i", "jj", "<Esc>", { noremap = false })

-- map("n", "<leader>r", function() -- toggle lsp loclist
--   local loclist_win = vim.fn.getloclist(0, { winid = 0 }).winid
--   if loclist_win > 0 then
--     vim.cmd("lclose")
--   else
--     vim.diagnostic.setloclist({ open = true })
--   end
-- end, opts)
-- map("n", "<leader>s", function() -- toggle quickfix
--   for _, win in ipairs(vim.fn.getwininfo()) do
--     if win.quickfix == 1 then
--       vim.cmd("cclose")
--       return
--     end
--   end
--   vim.cmd("copen")
-- end)

local augroup = vim.api.nvim_create_augroup("erock.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
autocmd("Filetype", { group = augroup, pattern = "make", command = "setlocal noexpandtab tabstop=4 shiftwidth=4" })
autocmd("BufEnter", { -- disable automatic newline comment continuation
  callback = function()
    o.formatoptions = vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Vim pack update hooks
local hooks = function(ev)
  -- Use available |event-data|
  local name, kind = ev.data.spec.name, ev.data.kind
  -- Run build script after plugin's code has changed
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    print('compiling telescope-fzf')
    local obj = vim.system(
      { 'make' },
      {
        cwd = ev.data.path,
        env = { CFLAGS = '-march=native' },
      }
    ):wait()
    print(obj.stdout)
    print(obj.stderr)
    if obj.code ~= 0 then
      print("Error compiling, see :messages")
      error(obj.stderr)
    end
  end
  -- If action relies on code from the plugin (like user command or
  -- Lua code), make sure to explicitly load it first
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then
      vim.cmd.packadd('nvim-treesitter')
    end
    require('nvim-treesitter').update(nil, { summary = true })
  end
end
-- If hooks need to run on install, run this before `vim.pack.add()`
-- To act on install from lockfile, run before very first `vim.pack.add()`
autocmd('PackChanged', { callback = hooks })

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
  gh("nvim-lua/plenary.nvim"),
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("s1n7ax/nvim-window-picker"),
  gh("rcarriga/nvim-notify"),

  gh("catppuccin/nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("stevearc/conform.nvim"),
  gh("kdheepak/lazygit.nvim"),
  gh("linrongbin16/gitlinker.nvim"),
  gh("sindrets/diffview.nvim"),
  gh("nvim-mini/mini.pairs"),
  gh("folke/ts-comments.nvim"),
  gh("folke/todo-comments.nvim"),
  gh('neovim/nvim-lspconfig'),
  -- TS
  gh("nvim-treesitter/nvim-treesitter"),
  -- Telescope
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  -- Neotree
  {
    src = gh("nvim-neo-tree/neo-tree.nvim"),
    version = vim.version.range('3')
  },
  -- Noice
  gh("folke/noice.nvim"),

  gh("nvim-lualine/lualine.nvim"),

  gh("folke/snacks.nvim"),

  -- Go
  gh('ray-x/go.nvim'),
  gh('ray-x/guihua.lua'),
})

require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  -- explorer = { enabled = true },
  indent = {
    enabled = true,
    animate = { enabled = false },
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  -- picker = { enabled = true },
  -- quickfile = { enabled = true },
  scope = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    },
  },
})


-- require("vim._extui").enable({}) -- https://github.com/neovim/neovim/pull/27855
require("gitlinker").setup()
require("diffview").setup({ use_icons = false })

-- TELESCOPE
require('telescope').load_extension('fzf')
require("telescope").load_extension("noice")
local telescope = require('telescope.builtin')

map('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
map('n', '<leader><space>', telescope.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })

-- window picker
require("window-picker").setup()

-- DISABLED
-- "https://github.com/tpope/vim-fugitive",

-- "https://github.com/karb94/neoscroll.nvim",
-- require("neoscroll").setup({ duration_multiplier = 0.3 })

-- "https://github.com/nvim-mini/mini.pick",
-- "https://github.com/nvim-mini/mini.files",
-- map("n", "<leader>f", "<cmd>Pick files<cr>")
-- map("n", "<leader>g", "<cmd>Pick grep_live<cr>")
-- map("n", "<leader>a", "<cmd>lua MiniFiles.open()<cr>")
-- require("mini.pick").setup()
-- require("mini.files").setup()

require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  auto_integrations = false,
})
vim.cmd.colorscheme "catppuccin"

require('lualine').setup {}
require('treesitter')
require('lsp')
require('autocomplete')
require('ui')

require('go').setup({})
