local cycle_layouts = { "telescope", "ivy", "vscode" }

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layout = {
          preset = "telescope",
        },
        sources = {
          files = { layout = { preset = "vscode" } },
          git_files = { layout = { preset = "vscode" } },
          recent = { layout = { preset = "vscode" } },
          smart = { layout = { preset = "vscode" } },
        },
        actions = {
          cycle_layout = function(picker)
            local idx = picker._layout_idx or 1
            idx = idx % #cycle_layouts + 1
            picker._layout_idx = idx
            picker:set_layout(cycle_layouts[idx])
          end,
        },
        win = {
          input = {
            keys = {
              ["<a-l>"] = { "cycle_layout", mode = { "n", "i" } },
            },
          },
        },
      },
    },
  },
}
