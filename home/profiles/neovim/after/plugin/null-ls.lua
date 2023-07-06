local fs = require("jc.fs")
local lsp = require("jc.lsp")
local null_ls = require("null-ls")

local sources = {}

if fs.is_executable("deadnix") then
  table.insert(sources, null_ls.builtins.diagnostics.deadnix)
end

if fs.is_executable("prettierd") then
  table.insert(
    sources,
    null_ls.builtins.formatting.prettierd.with({
      extra_filetypes = { "svelte" },
    })
  )
end

if fs.is_executable("eslint_d") then
  table.insert(
    sources,
    null_ls.builtins.code_actions.eslint_d.with({
      extra_filetypes = { "svelte" },
    })
  )
  table.insert(
    sources,
    null_ls.builtins.diagnostics.eslint_d.with({
      extra_filetypes = { "svelte" },
    })
  )
end

null_ls.setup({
  sources = sources,
  on_attach = lsp.on_attach(),
})
