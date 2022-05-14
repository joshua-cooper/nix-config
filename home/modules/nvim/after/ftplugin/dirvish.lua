local opts = {
  noremap = true,
}

vim.api.nvim_buf_set_keymap(0, "n", "F", ":edit %", opts)
vim.api.nvim_buf_set_keymap(0, "n", "D", ":!mkdir -p %", opts)
