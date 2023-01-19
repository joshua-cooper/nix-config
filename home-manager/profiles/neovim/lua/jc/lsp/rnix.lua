require("jc.lsp")

local M = {}

function M.start()
  if not require("jc.utils").is_executable("rnix-lsp") then
    return
  end

  vim.lsp.start({
    name = "rnix-lsp",
    cmd = { "rnix-lsp" },
  })
end

return M
