local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completion_capabilities = require("cmp_nvim_lsp").default_capabilities().textDocument.completion
  capabilities.textDocument.completion = completion_capabilities
  return capabilities
end

function M.on_attach(fn)
  return function(client, buf)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buf,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              return client.name ~= "tsserver"
            end,
          })
        end,
      })
    end

    if client.server_capabilities.codeActionProvider then
      vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
        desc = "Code actions",
        buffer = buf,
      })
    end

    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = buf,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })

      vim.keymap.set("n", "<leader>c", "<cmd>lua vim.lsp.codelens.run()<cr>", {
        desc = "Code lenses",
        buffer = buf,
      })
    end

    if client.server_capabilities.workspaceSymbolProvider then
      vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", {
        desc = "Document symbols",
        buffer = buf,
      })

      vim.keymap.set("n", "<leader>S", "<cmd>Telescope lsp_workspace_symbols<cr>", {
        desc = "Workspace symbols",
        buffer = buf,
      })
    end

    if client.server_capabilities.hoverProvider then
      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {
        desc = "Hover",
        buffer = buf,
      })
    end

    if client.server_capabilities.referencesProvider then
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
        desc = "References",
        buffer = buf,
      })
    end

    if client.server_capabilities.renameProvider then
      vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", {
        desc = "Rename",
        buffer = buf,
      })
    end

    if client.server_capabilities.implementationProvider then
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {
        desc = "Implementations",
        buffer = buf,
      })
    end

    if client.server_capabilities.typeDefinitionProvider then
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_type_definitions<cr>", {
        desc = "Type definitions",
        buffer = buf,
      })
    end

    if fn then
      fn(client, buf)
    end
  end
end

return M
