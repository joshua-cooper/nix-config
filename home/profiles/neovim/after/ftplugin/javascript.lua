if vim.fs.find("package.json", { upward = true })[1] then
  require("jc.lsp.tsserver").start()
else
  require("jc.lsp.deno").start()
end
