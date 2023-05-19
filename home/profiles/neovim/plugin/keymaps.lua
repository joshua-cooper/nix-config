local utils = require("xos.utils")

vim.keymap.set({ "n", "v" }, "<leader><leader>", ":")
vim.keymap.set("n", "<leader><tab>", "<cmd>buffer #<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm quitall<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<m-n>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<m-N>", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", function()
  vim.cmd.Git("log")
end)

vim.keymap.set("n", "<leader>gb", function()
  vim.cmd.Telescope("git_branches")
end)

vim.keymap.set("n", "<leader>b", function()
  vim.cmd.Telescope("buffers")
end)

vim.keymap.set("n", "<leader>f", function()
  vim.cmd.Telescope("try_git_files", "show_untracked=true")
end)

vim.keymap.set("n", "<leader>se", function()
  utils.on_input("Global search: ", function(input)
    vim.cmd.Telescope("grep_string", ("search=%s"):format(input))
  end)
end)

vim.keymap.set("n", "<leader>sr", function()
  utils.on_input("Global regex: ", function(input)
    vim.cmd.Telescope("grep_string", "use_regex=true", ("search=%s"):format(input))
  end)
end)

vim.keymap.set({ "i", "c" }, "<c-b>", "<left>")
vim.keymap.set({ "i", "c" }, "<c-f>", "<right>")
vim.keymap.set({ "i", "c" }, "<c-a>", "<home>")
vim.keymap.set({ "i", "c" }, "<c-e>", "<end>")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
