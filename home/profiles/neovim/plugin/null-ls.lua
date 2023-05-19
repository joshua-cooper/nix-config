local utils = require("xos.utils")
local lsp = require("xos.lsp")
local null_ls = require("null-ls")

local sources = {}

if utils.is_executable("deadnix") then
  table.insert(sources, null_ls.builtins.diagnostics.deadnix)
end

if utils.is_executable("prettierd") then
  table.insert(sources, null_ls.builtins.formatting.prettierd)
end

if utils.is_executable("eslint_d") then
  table.insert(sources, null_ls.builtins.code_actions.eslint_d)
  table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
end

null_ls.setup({
  sources = sources,
  on_attach = lsp.on_attach(),
})
