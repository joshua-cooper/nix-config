require("jc.lsp")

local M = {}

function M.start()
  if not require("jc.utils").is_executable("deno") then
    return
  end

  vim.lsp.start({
    name = "deno",
    cmd = { "deno", "lsp" },
    init_options = {
      enable = true,
    },
  })
end

return M
