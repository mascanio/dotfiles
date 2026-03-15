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

map("n", "<leader>e", vim.diagnostic.open_float, opts)
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
require("lazy").setup({

  -- ── Dependencies ────────────────────────────────────────────────────────
  { "nvim-lua/plenary.nvim",        lazy = true },
  { "MunifTanjim/nui.nvim",         lazy = true },
  { "nvim-tree/nvim-web-devicons",  lazy = true },
  { "s1n7ax/nvim-window-picker",    lazy = true, config = true },
  { "rcarriga/nvim-notify",         lazy = true },
  { "ray-x/guihua.lua",             lazy = true },

  -- ── Colorscheme ─────────────────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        auto_integrations = false,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ── LSP ─────────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp")
    end,
  },

  -- ── Completion (blink.cmp) ───────────────────────────────────────────────
  {
    "saghen/blink.cmp",
    version = "1.*",
    config = function()
      require("autocomplete")
    end,
  },

  -- ── Formatter ───────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("formatter")
    end,
  },

  -- ── Git ─────────────────────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "linrongbin16/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({ use_icons = false })
    end,
  },

  -- ── Editing ─────────────────────────────────────────────────────────────
  { "nvim-mini/mini.pairs" },
  { "folke/ts-comments.nvim",    opts = {} },
  { "folke/todo-comments.nvim",  dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

  -- ── Treesitter ──────────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter").update(nil, { summary = true })
    end,
    config = function()
      require("treesitter")
    end,
  },

  -- ── Telescope ───────────────────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = function(plugin)
          vim.system({ "make" }, { cwd = plugin.dir, env = { CFLAGS = "-march=native" } }):wait()
        end,
      },
      "folke/noice.nvim", -- needed so noice is set up before telescope loads its extension
    },
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("noice")
      local telescope = require("telescope.builtin")
      map("n", "<leader>ff",    telescope.find_files, { desc = "Telescope find files" })
      map("n", "<leader><space>", telescope.find_files, { desc = "Telescope find files" })
      map("n", "<leader>fg",    telescope.live_grep,  { desc = "Telescope live grep" })
      map("n", "<leader>fb",    telescope.buffers,    { desc = "Telescope buffers" })
      map("n", "<leader>fh",    telescope.help_tags,  { desc = "Telescope help tags" })
    end,
  },

  -- ── File explorer ────────────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "^3",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
  },

  -- ── UI ───────────────────────────────────────────────────────────────────
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
              },
            },
            view = "mini",
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("snacks").setup({
        bigfile    = { enabled = true },
        dashboard  = { enabled = true },
        indent     = { enabled = true, animate = { enabled = false } },
        input      = { enabled = true },
        notifier   = { enabled = true, timeout = 3000 },
        scope      = { enabled = true },
        statuscolumn = { enabled = true },
        words      = { enabled = true },
        styles     = { notification = {} },
      })
    end,
  },

  -- ── Go ───────────────────────────────────────────────────────────────────
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig" },
    config = function()
      require("go").setup({})
    end,
    ft = { "go", "gomod", "gowork", "gotmpl" },
  },

}, {
  -- lazy.nvim options
  ui = { border = "rounded" },
})

-- ─── Post-plugin setup that depends on several plugins ───────────────────────
require("ui")
