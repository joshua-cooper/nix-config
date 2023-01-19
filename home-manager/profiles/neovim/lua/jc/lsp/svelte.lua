require("jc.lsp")

local M = {}

function M.start()
  if not require("jc.utils").is_executable("svelteserver") then
    return
  end

  vim.lsp.start({
    name = "svelte",
    cmd = { "svelteserver", "--stdio" },
  })
end

return M
