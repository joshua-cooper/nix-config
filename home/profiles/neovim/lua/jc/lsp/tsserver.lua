require("jc.lsp")

local M = {}

function M.organize_imports()
  vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    title = "",
    arguments = {
      vim.api.nvim_buf_get_name(0),
    },
  })
end

function M.start()
  if not require("jc.utils").is_executable("typescript-language-server") then
    return
  end

  vim.lsp.start({
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    init_options = {
      hostInfo = "neovim",
    },
  })
end

return M
