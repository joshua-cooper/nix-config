local lsp = require("xos.lsp")

local M = {}

function M.start()
  vim.lsp.start({
    name = "svelte",
    cmd = { "svelteserver", "--stdio" },
    capabilities = lsp.capabilities(),
    on_attach = lsp.on_attach(),
  })
end

return M
