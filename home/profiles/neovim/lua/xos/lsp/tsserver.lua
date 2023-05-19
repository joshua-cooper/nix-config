local lsp = require("xos.lsp")

local M = {}

function M.organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    title = "Organize imports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf_request_sync(0, "workspace/executeCommand", params, 1000)
end

function M.start()
  vim.lsp.start({
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = lsp.capabilities(),
    init_options = {
      hostInfo = "neovim",
    },
    on_attach = lsp.on_attach(function(client, buf)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("TsserverOrganizeImports", {}),
        buffer = buf,
        callback = function()
          M.organize_imports()
        end,
      })

      vim.keymap.set("n", "<leader>lo", M.organize_imports, {
        buffer = buf,
        desc = "Organize imports",
      })
    end),
  })
end

return M
