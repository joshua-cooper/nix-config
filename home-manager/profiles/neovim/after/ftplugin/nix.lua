if jc.is_executable("rnix-lsp") then
  vim.lsp.start({
    name = "rnix-lsp",
    cmd = { "rnix-lsp" },
    root_dir = jc.root_dir(".git") or vim.fn.getcwd(),
  })
end
