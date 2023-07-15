vim.keymap.set({ "n", "v" }, "<leader><leader>", ":")
vim.keymap.set("n", "<leader><tab>", "<cmd>buffer #<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm quitall<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>confirm bdelete<cr>")

-- Readline
vim.keymap.set({ "i", "c" }, "<c-b>", "<left>")
vim.keymap.set({ "i", "c" }, "<c-f>", "<right>")
vim.keymap.set({ "i", "c" }, "<c-a>", "<home>")
vim.keymap.set({ "i", "c" }, "<c-e>", "<end>")

-- Terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
