# Neovim LSP & Linter Installation

External language servers and linters must be installed separately. This config
uses `vim.lsp.enable()` (nvim 0.11+) — once the binary is on `$PATH`, the
server starts automatically for the relevant filetypes.

---

## Go

| Server | Purpose |
|--------|---------|
| `gopls` | LSP (types, completion, diagnostics, formatting) |

```sh
go install golang.org/x/tools/gopls@latest
```

---

## Python

| Server | Purpose |
|--------|---------|
| `pyright` | LSP (types, completion, diagnostics) |
| `ruff` | Fast linter + formatter (runs alongside pyright) |

```sh
# pyright
npm install -g pyright
# or via pipx
pipx install pyright

# ruff
pip install ruff
# or via pipx
pipx install ruff
```

> Both servers run simultaneously. Pyright handles type inference; ruff handles
> linting and formatting. To avoid duplicate diagnostics, pyright's formatting
> is intentionally left to ruff — configure `ruff` rules in `pyproject.toml` or
> `ruff.toml`.

---

## Docker

| Server | Purpose |
|--------|---------|
| `dockerls` | LSP for `Dockerfile` |
| `docker_compose_language_service` | LSP for `docker-compose.yml` / `compose.yml` |

```sh
npm install -g dockerfile-language-server-nodejs
npm install -g @microsoft/compose-language-service
```

> `docker_compose_language_service` requires the filetype to be
> `yaml.docker-compose`. Neovim sets this automatically for files named
> `docker-compose.yml`, `docker-compose.yaml`, `compose.yml`, `compose.yaml`.

---

## JSON

| Server | Purpose |
|--------|---------|
| `jsonls` | LSP (validation, completion, formatting) |

```sh
npm install -g vscode-langservers-extracted
```

> This package also provides `htmlls` and `cssls` if needed later.

---

## YAML

| Server | Purpose |
|--------|---------|
| `yamlls` | LSP (validation, completion, schema support) |

```sh
npm install -g yaml-language-server
# or via yarn
yarn global add yaml-language-server
```

> Schema validation is enabled via `schemaStore`. To attach a schema manually,
> add a modeline at the top of the file:
> ```yaml
> # yaml-language-server: $schema=https://example.com/schema.json
> ```

---

## Markdown

| Server | Purpose |
|--------|---------|
| `marksman` | LSP (link completion, cross-references, diagnostics) |

Download the pre-built binary from https://github.com/artempyanykh/marksman/releases
and place it on `$PATH`:

```sh
# Linux example
curl -Lo ~/.local/bin/marksman \
  https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64
chmod +x ~/.local/bin/marksman
```

---

## Lua

| Server | Purpose |
|--------|---------|
| `lua_ls` | LSP (types, completion, diagnostics) |

```sh
# via Mason (inside nvim): :MasonInstall lua-language-server
# or manually (Arch)
sudo pacman -S lua-language-server
# or download from https://github.com/LuaLS/lua-language-server/releases
```

---

## Verifying a server is running

Open a file of the relevant type and run:
```
:lua vim.print(vim.lsp.get_clients())
```
or check with:
```
:checkhealth lsp
```
