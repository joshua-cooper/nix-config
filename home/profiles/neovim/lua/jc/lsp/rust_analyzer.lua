require("jc.lsp")

local utils = require("jc.utils")

local M = {}

function M.expand_macro()
  vim.lsp.buf_request(0, "rust-analyzer/expandMacro", vim.lsp.util.make_position_params(), function(_, result)
    if not result then
      vim.notify("No macro under the cursor")
      return
    end

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(bufnr, "filetype", "rust")
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(result.expansion, "\n", true))
    vim.api.nvim_set_current_buf(bufnr)
  end)
end

function M.start()
  if not utils.is_executable("rust-analyzer") then
    return
  end

  vim.lsp.start({
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          features = "all",
        },
        check = {
          command = utils.is_executable("cargo-clippy") and "clippy" or "check",
        },
        lens = {
          enable = false,
        },
      },
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>lm", M.expand_macro, { buffer = bufnr })
    end,
  })
end

return M
