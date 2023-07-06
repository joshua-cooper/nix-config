local fs = require("jc.fs")
local lsp = require("jc.lsp")

local M = {}

function M.start()
  if not fs.is_executable("svelteserver") then
    return
  end

  vim.lsp.start({
    name = "svelte",
    cmd = { "svelteserver", "--stdio" },
    capabilities = lsp.capabilities(),
    on_attach = lsp.on_attach(),
  })
end

return M
