local fs = require("jc.fs")
local lsp = require("jc.lsp")

local M = {}

function M.organize_imports(buf)
  local params = {
    command = "_typescript.organizeImports",
    title = "Organize imports",
    arguments = { vim.api.nvim_buf_get_name(buf or 0) },
  }
  vim.lsp.buf_request_sync(buf or 0, "workspace/executeCommand", params, 1000)
end

function M.start()
  if not fs.is_executable("tsserver") then
    return
  end

  vim.lsp.start({
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = lsp.capabilities(),
    init_options = {
      hostInfo = "neovim",
    },
    on_attach = lsp.on_attach(function(client, buf)
      vim.keymap.set("n", "<leader>lo", function()
        M.organize_imports(buf)
      end, {
        buffer = buf,
        desc = "Organize imports",
      })
    end),
  })
end

return M
