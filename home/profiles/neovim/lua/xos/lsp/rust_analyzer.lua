local lsp = require("xos.lsp")
local utils = require("xos.utils")

local M = {}

function M.reload_workspace()
  vim.lsp.buf_request(0, "rust-analyzer/reloadWorkspace", nil, function(err)
    if err then
      error(tostring(err))
    else
      vim.notify("Workspace reloaded")
    end
  end)
end

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
  vim.lsp.start({
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    capabilities = lsp.capabilities(),
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          features = "all",
        },
        check = {
          command = utils.is_executable("cargo-clippy") and "clippy" or "check",
        },
      },
    },
    on_attach = lsp.on_attach(function(client, buf)
      vim.keymap.set("n", "<leader>lr", M.reload_workspace, {
        buffer = buf,
        desc = "Reload workspace",
      })

      vim.keymap.set("n", "<leader>lm", M.expand_macro, {
        buffer = buf,
        desc = "Expand macro",
      })
    end),
  })
end

vim.lsp.commands["rust-analyzer.runSingle"] = function(command)
  local args = command.arguments[1].args
  local c = { "cargo" }

  for _, arg in ipairs(args.cargoArgs) do
    table.insert(c, arg)
  end

  for _, arg in ipairs(args.cargoExtraArgs) do
    table.insert(c, arg)
  end

  table.insert(c, "--")

  for _, arg in ipairs(args.executableArgs) do
    table.insert(c, arg)
  end

  utils.run_command({
    command = c,
    cwd = args.workspaceRoot,
  })
end

return M
