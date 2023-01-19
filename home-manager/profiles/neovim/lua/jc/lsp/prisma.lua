require("jc.lsp")

local M = {}

function M.start()
  if not require("jc.utils").is_executable("prisma-language-server") then
    return
  end

  vim.lsp.start({
    name = "prisma",
    cmd = { "prisma-language-server", "--stdio" },
  })
end

return M
