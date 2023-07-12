vim.diagnostic.config({
  signs = false,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
})

vim.keymap.set("n", "<c-k>", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<m-n>", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<m-N>", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
