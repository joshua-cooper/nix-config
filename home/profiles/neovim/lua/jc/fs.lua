local M = {}

function M.is_executable(path)
  return vim.fn.executable(path) == 1
end

return M
