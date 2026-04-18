return {
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
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>ff",      builtin.find_files, { desc = "Telescope find files" })
    map("n", "<leader><space>", builtin.find_files, { desc = "Telescope find files" })
    map("n", "<leader>fg",      builtin.live_grep,  { desc = "Telescope live grep" })
    map("n", "<leader>fb",      builtin.buffers,    { desc = "Telescope buffers" })
    map("n", "<leader>fh",      builtin.help_tags,  { desc = "Telescope help tags" })
  end,
}
