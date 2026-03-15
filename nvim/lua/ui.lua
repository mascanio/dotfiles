local map = vim.keymap.set

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
  -- skip autopair when next character is one of these
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  -- skip autopair when the cursor is inside these treesitter nodes
  skip_ts = { "string" },
  -- skip autopair when next character is closing pair
  -- and there are more closing pairs than opening pairs
  skip_unbalanced = true,
  -- better deal with markdown code blocks
  markdown = true,
})
require("todo-comments").setup()

-- NEO TREE
map("n", "<leader>e", function() require("neo-tree.command").execute({ toggle = true }) end)
-- :lua require("neo-tree").paste_default_config()
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    -- bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    git_status = {
      symbols = {
        unstaged = "󰄱",
        staged = "󰱒",
      },
    },
  },
})
