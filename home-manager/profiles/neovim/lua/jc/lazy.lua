local M = {}

local function lazy_command(command, plugin, setup)
  vim.api.nvim_create_user_command(command, function(event)
    vim.api.nvim_del_user_command(command)
    vim.cmd.packadd(plugin)
    setup()
    vim.cmd(
      ("%s %s%s%s %s"):format(
        event.mods or "",
        event.line1 == event.line2 and "" or event.line1 .. "," .. event.line2,
        command,
        event.bang and "!" or "",
        event.args or ""
      )
    )
  end, {
    bang = true,
    range = true,
    nargs = "*",
    complete = function(_, line)
      vim.cmd.packadd(plugin)
      setup()
      return vim.fn.getcompletion(line, "cmdline")
    end,
  })
end

function M.plugin(opts)
  local setup = opts.setup or function() end

  if opts.lazy == false then
    vim.cmd.packadd(opts.name)
    setup()
    return
  end

  for _, command in ipairs(opts.commands or {}) do
    lazy_command(command, opts.name, setup)
  end
end

return M
