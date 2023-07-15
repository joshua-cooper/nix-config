local fs = require("jc.fs")
local lsp = require("jc.lsp")
local runners = require("jc.runners")

local M = {}

function M.reload_workspace(buf)
  vim.lsp.buf_request(buf or 0, "rust-analyzer/reloadWorkspace", nil, function(err)
    if err then
      error(tostring(err))
    else
      vim.notify("Workspace reloaded")
    end
  end)
end

function M.expand_macro(buf)
  vim.lsp.buf_request(buf or 0, "rust-analyzer/expandMacro", vim.lsp.util.make_position_params(), function(_, result)
    if not result then
      vim.notify("No macro under the cursor")
      return
    end

    local b = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(b, "filetype", "rust")
    vim.api.nvim_buf_set_lines(b, 0, -1, false, vim.split(result.expansion, "\n", true))
    vim.api.nvim_set_current_buf(b)
  end)
end

function M.start()
  if not fs.is_executable("rust-analyzer") then
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
          command = fs.is_executable("cargo-clippy") and "clippy" or "check",
        },
        files = {
          excludeDirs = {
            ".direnv"
          },
        },
      },
    },
    capabilities = lsp.capabilities(),
    on_attach = lsp.on_attach(function(client, buf)
      vim.keymap.set("n", "<leader>lr", function()
        M.reload_workspace(buf)
      end, {
        buffer = buf,
        desc = "Reload workspace",
      })

      vim.keymap.set("n", "<leader>lm", function()
        M.expand_macro(buf)
      end, {
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

  runners.terminal({
    command = c,
    cwd = args.workspaceRoot,
  })
end

return M
