vim.diagnostic.config({
  signs = false,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
})

vim.keymap.set("n", "<c-k>", vim.diagnostic.open_float, { desc = "Show diagnostic" })
