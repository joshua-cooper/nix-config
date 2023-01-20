local utils = require("jc.utils")
local null_ls = require("null-ls")

local sources = {}

if utils.is_executable("eslint_d") then
  sources[#sources + 1] = null_ls.builtins.diagnostics.eslint_d.with({
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
  })
end

if utils.is_executable("prettierd") then
  sources[#sources + 1] = null_ls.builtins.formatting.prettierd.with({
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
    },
  })
end

null_ls.setup({
  sources = sources,
})
