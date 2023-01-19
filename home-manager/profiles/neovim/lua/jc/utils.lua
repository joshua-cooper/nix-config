local M = {}

function M.is_executable(path)
  return vim.fn.executable(path) == 1
end

function M.on_input(prompt, fn)
  local input = vim.fn.input(prompt)

  if input ~= "" then
    return fn(input)
  end
end

return M
