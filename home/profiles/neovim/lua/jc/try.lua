local M = {}

function M.call(label, fn)
  local result = { pcall(fn) }

  if not result[1] then
    vim.notify(string.format("%s error: %s", label, result[2]), vim.log.levels.ERROR)
  end

  return result
end

return M
