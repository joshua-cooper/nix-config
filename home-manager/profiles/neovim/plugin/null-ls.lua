local utils = require("jc.utils")
local null_ls = require("null-ls")

local sources = {}

if utils.is_executable("eslint_d") then
  sources[#sources + 1] = null_ls.builtins.diagnostics.eslint_d
end

if utils.is_executable("prettierd") then
  sources[#sources + 1] = null_ls.builtins.formatting.prettierd
end

null_ls.setup({
  sources = sources,
})
