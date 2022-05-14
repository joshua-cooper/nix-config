-- Global variables

vim.g.mapleader = " "
vim.g.loaded_netrwPlugin = true

-- Default options

vim.o.showcmd = false
vim.o.showmode = true
vim.o.ruler = false
vim.o.undofile = false
vim.o.lazyredraw = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.inccommand = "nosplit"
vim.o.mouse = "a"
vim.o.hidden = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = "menu"
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.list = true
vim.o.wrap = false
vim.o.listchars = "eol: ,tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.o.fillchars = "fold: ,vert:│,eob:~,msgsep:‾"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldmethod = "manual"

-- Highlight on yank

local yank_group = vim.api.nvim_create_augroup("InitYank", {})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = yank_group,
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200, on_visual = false })
  end,
})

-- Terminal options

local terminal_group = vim.api.nvim_create_augroup("InitTerminal", {})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = terminal_group,
  pattern = { "*" },
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- Treesitter

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
})

-- Comments

require("Comment").setup()

-- Fuzzy finding

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
      vertical = {
        mirror = false,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--strip-cwd-prefix",
        "--hidden",
        "--follow",
        "--type",
        "file",
        "--exclude",
        ".git/",
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

require("telescope").load_extension("find_directories")
require("telescope").load_extension("try_git_files")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

-- LSP

require("fidget").setup({
  text = {
    spinner = "bouncing_bar",
  },
})

local lsp_group = vim.api.nvim_create_augroup("InitLsp", {})

local lsp = {
  autostart = false,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = lsp_group,
      buffer = 0,
      callback = function()
        vim.lsp.buf.formatting_sync()
      end,
    })
  end,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
})

require("lspconfig").rnix.setup({
  autostart = lsp.autostart,
  on_attach = lsp.on_attach,
})

require("lspconfig").rust_analyzer.setup({
  autostart = lsp.autostart,
  on_attach = lsp.on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

require("lspconfig").denols.setup({
  autostart = lsp.autostart,
  on_attach = lsp.on_attach,
  init_options = {
    lint = true,
  },
})

require("lspconfig").gopls.setup({
  autostart = lsp.autostart,
  on_attach = lsp.on_attach,
})

-- Keymaps

vim.api.nvim_set_keymap("n", "<m-h>", "<c-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<m-j>", "<c-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<m-k>", "<c-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<m-l>", "<c-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>confirm quitall<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Telescope try_git_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>Telescope find_directories<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
