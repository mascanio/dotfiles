return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lsp")

    -- ─── LSP Attach: keymaps, inlay hints, codelens ──────────────────────────
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(ev)
        local buf = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
          return
        end

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end

        -- ── Navigation (via Telescope) ──────────────────────────────────────
        map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, "Goto Definition")
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")
        map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, "Goto Implementation")
        map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, "Goto T[y]pe Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

        -- ── Docs / Hover ───────────────────────────────────────────────────
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")

        -- ── Code actions ───────────────────────────────────────────────────
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>cA", function()
          vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
        end, "Source Action")
        map("n", "<leader>co", function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.organizeImports" }, diagnostics = {} },
          })
        end, "Organize Imports")
        if Snacks and Snacks.rename then
          map("n", "<leader>cR", function() Snacks.rename.rename_file() end, "Rename File")
        end

        -- ── Codelens ───────────────────────────────────────────────────────
        if client:supports_method("textDocument/codeLens") then
          map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
          map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")

          vim.lsp.codelens.refresh({ bufnr = buf })
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buf,
            callback = function()
              vim.lsp.codelens.refresh({ bufnr = buf })
            end,
          })
        end

        -- ── Inlay hints toggle ─────────────────────────────────────────────
        if client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = buf })

          map("n", "<leader>ch", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
              { bufnr = buf }
            )
          end, "Toggle Inlay Hints")
        end

        -- ── Word references (Snacks.words) ─────────────────────────────────
        if client:supports_method("textDocument/documentHighlight") and Snacks and Snacks.words then
          map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
          map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
        end

        -- ── LSP folding ────────────────────────────────────────────────────
        if client:supports_method("textDocument/foldingRange") then
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end,
    })
  end,
}
