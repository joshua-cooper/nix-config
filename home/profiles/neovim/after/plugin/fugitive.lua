local runners = require("jc.runners")

vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Git log" })
