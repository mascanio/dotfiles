vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    -- prefix = "icons",
  },
  severity_sort = true,
})

-- ─── Python ──────────────────────────────────────────────────────────────────
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
})
vim.lsp.enable('pyright')

-- ruff: fast linter + formatter (replaces pyright's formatting)
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      -- ruff CLI args can go here, e.g.: args = { '--select', 'ALL' }
    },
  },
})
vim.lsp.enable('ruff')

-- ─── Docker ──────────────────────────────────────────────────────────────────
vim.lsp.enable('dockerls')

-- docker-compose files use filetype 'yaml.docker-compose'
vim.lsp.enable('docker_compose_language_service')

-- ─── JSON ─────────────────────────────────────────────────────────────────────
vim.lsp.enable('jsonls')

-- ─── YAML ─────────────────────────────────────────────────────────────────────
vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      format = { enable = true },
      validate = true,
      schemaStore = { enable = true, url = 'https://www.schemastore.org/api/json/catalog.json' },
    },
    redhat = { telemetry = { enabled = false } },
  },
})
vim.lsp.enable('yamlls')

-- ─── Markdown ────────────────────────────────────────────────────────────────
vim.lsp.enable('marksman')

-- ─── Lua ─────────────────────────────────────────────────────────────────────
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library',
            -- '${3rd}/busted/library',
          },
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = vim.api.nvim_get_runtime_file('', true),
        },
      })
    end,
    settings = {
      Lua = {},
    },
  }
)
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
