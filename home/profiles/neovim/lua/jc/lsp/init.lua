local try = require("jc.try")

local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completion_capabilities = require("cmp_nvim_lsp").default_capabilities().textDocument.completion
  capabilities.textDocument.completion = completion_capabilities
  return capabilities
end

local function common_on_attach(client, buf)
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

  if client.server_capabilities.hoverProvider then
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      buffer = buf,
      desc = "Hover",
    })
  end

  if client.server_capabilities.codeActionProvider then
    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, {
      buffer = buf,
      desc = "Code actions",
    })
  end

  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = buf,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })

    vim.keymap.set("n", "<leader>c", vim.lsp.codelens.run, {
      buffer = buf,
      desc = "Code lenses",
    })
  end

  if client.server_capabilities.renameProvider then
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
      buffer = buf,
      desc = "Rename",
    })
  end

  if client.server_capabilities.workspaceSymbolProvider then
    vim.keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", {
      buffer = buf,
      desc = "Document symbols",
    })

    vim.keymap.set("n", "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {
      buffer = buf,
      desc = "Workspace symbols",
    })
  end

  if client.server_capabilities.referencesProvider then
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
      buffer = buf,
      desc = "References",
    })
  end

  if client.server_capabilities.implementationProvider then
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {
      buffer = buf,
      desc = "Implementations",
    })
  end

  if client.server_capabilities.typeDefinitionProvider then
    vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<cr>", {
      buffer = buf,
      desc = "Type definitions",
    })
  end
end

function M.on_attach(fn)
  return function(client, buf)
    local label = "LSP on_attach"

    try.call(label, function()
      common_on_attach(client, buf)
    end)

    if fn then
      try.call(label, function()
        fn(client, buf)
      end)
    end
  end
end

return M
