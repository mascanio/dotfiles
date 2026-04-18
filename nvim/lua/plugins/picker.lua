local file_layouts = { "vscode", "telescope", "ivy" }
local default_layouts = { "telescope", "ivy" }

local vscode_sources = { files = true, git_files = true, recent = true, smart = true }

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
            local layouts = vscode_sources[picker.opts.source] and file_layouts or default_layouts
            local idx = picker._layout_idx or 1
            idx = idx % #layouts + 1
            picker._layout_idx = idx
            picker._layout_preset = layouts[idx]
            picker:set_layout(layouts[idx])
          end,
          smart_esc = function(picker)
            local mode = vim.api.nvim_get_mode().mode
            if picker._layout_preset == "vscode" or mode == "n" then
              picker:close()
            else
              vim.cmd("stopinsert")
            end
          end,
        },
        on_show = function(picker)
          if not picker._layout_preset then
            picker._layout_preset = vscode_sources[picker.opts.source] and "vscode" or "telescope"
            picker._layout_idx = vscode_sources[picker.opts.source] and 3 or 1
          end
        end,
        win = {
          input = {
            keys = {
              ["<a-l>"] = { "cycle_layout", mode = { "n", "i" } },
              ["<Esc>"] = { "smart_esc", mode = { "n", "i" } },
            },
          },
        },
      },
    },
  },
}
