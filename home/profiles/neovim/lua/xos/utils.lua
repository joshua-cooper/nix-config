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

function M.run_command(opts)
  local bufnr = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(bufnr)
  vim.fn.termopen(opts.command, { cwd = opts.cwd or vim.fn.getcwd() })
end

return M
