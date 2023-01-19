vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

vim.cmd.colorscheme("gruvbox")

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200, on_visual = false })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalStyle", {}),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickfixStyle", {}),
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    -- TODO: opt_local.*:append overwrites the entire table
    -- opt.*:append works correctly
    vim.opt_local.fillchars:append({ eob = " " })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("sensitive_files", {}),
  pattern = "/dev/shm/*",
  callback = function()
    vim.opt_local.shada = ""
    vim.opt_local.backup = false
    vim.opt_local.writebackup = false
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
  end,
})
