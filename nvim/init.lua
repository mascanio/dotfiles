-- ─── Options ─────────────────────────────────────────────────────────────────
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
o.clipboard = "unnamedplus"

-- ─── Leader ───────────────────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─── Keymaps ─────────────────────────────────────────────────────────────────
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

map("n", "<leader>y", function() -- copy relative filepath to clipboard
  vim.fn.setreg("+", vim.fn.expand("%"))
end)

map("i", "jj", "<Esc>", { noremap = false })

-- ─── Autocmds ────────────────────────────────────────────────────────────────
local augroup = vim.api.nvim_create_augroup("erock.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
autocmd("Filetype", { group = augroup, pattern = "make", command = "setlocal noexpandtab tabstop=4 shiftwidth=4" })
autocmd("BufEnter", { -- disable automatic newline comment continuation
  callback = function()
    o.formatoptions = vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ─── lazy.nvim bootstrap ─────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ─── Plugins ─────────────────────────────────────────────────────────────────
require("lazy").setup("plugins", {
  ui = { border = "rounded" },
})
