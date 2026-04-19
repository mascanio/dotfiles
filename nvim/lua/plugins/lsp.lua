-- LSP server overrides
-- Uncomment `cmd` to override the binary path for any server.
-- Add settings to the `settings` block to override server-specific configuration.
-- Empty tables are safe — they deep-merge with LazyVim defaults without overriding them.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          -- cmd = { "/path/to/gopls" },
          settings = {
            gopls = {},
          },
        },
        lua_ls = {
          -- cmd = { "/path/to/lua-language-server" },
          settings = {
            Lua = {},
          },
        },
        jsonls = {
          -- cmd = { "/path/to/vscode-json-language-server", "--stdio" },
          settings = {
            json = {},
          },
        },
        yamlls = {
          -- cmd = { "/path/to/yaml-language-server", "--stdio" },
          settings = {
            yaml = {},
          },
        },
        dockerls = {
          -- cmd = { "/path/to/docker-langserver", "--stdio" },
        },
        docker_compose_language_service = {
          -- cmd = { "/path/to/docker-compose-langserver", "--stdio" },
        },
        marksman = {
          -- cmd = { "/path/to/marksman", "server" },
        },
        basedpyright = {
          -- cmd = { "/path/to/basedpyright-langserver", "--stdio" },
          settings = {
            basedpyright = {},
          },
        },
        ruff = {
          -- cmd = { "/path/to/ruff", "server" },
        },
        bashls = {
          -- cmd = { "/path/to/bash-language-server", "start" },
        },
      },
    },
  },
}
