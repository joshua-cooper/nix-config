-- Global variables

vim.g.mapleader = " "

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
vim.o.termguicolors = true

vim.cmd("colorscheme gruvbox")

-- Highlight on yank

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = vim.api.nvim_create_augroup("InitYank", {}),
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200, on_visual = false })
  end,
})

-- Terminal options

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = vim.api.nvim_create_augroup("InitTerminal", {}),
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
    ["file_browser"] = {
      dir_icon = "",
      hijack_netrw = true,
      hidden = true,
      mappings = {},
    },
  },
})

require("telescope").load_extension("find_directories")
require("telescope").load_extension("try_git_files")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")

-- LSP

require("fidget").setup({
  text = {
    spinner = { "" },
    done = "",
    comenced = "",
    completed = "",
  },
  timer = {
    fidget_decay = 0,
    task_decay = 0,
  },
  fmt = {
    stack_upwards = false,
  },
})

function lsp_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
  vim.keymap.set("v", "<leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { buffer = bufnr })

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("InitLsp", {}),
    buffer = 0,
    callback = function()
      vim.lsp.buf.formatting_sync()
    end,
  })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
})

require("lspconfig").rnix.setup({
  on_attach = lsp_on_attach,
})

require("lspconfig").rust_analyzer.setup({
  on_attach = lsp_on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
      rustfmt = {
        rangeFormatting = {
          enable = true,
        },
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
  on_attach = lsp_on_attach,
  init_options = {
    lint = true,
  },
})

require("lspconfig").tsserver.setup({
  on_attach = lsp_on_attach,
})

require("lspconfig").gopls.setup({
  on_attach = lsp_on_attach,
})

-- Keymaps

vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("n", "<m-l>", "<c-w>l")
vim.keymap.set("n", "<leader><leader>", ":")
vim.keymap.set("n", "<leader><tab>", "<cmd>buffer #<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm quitall<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>confirm bdelete<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope try_git_files show_untracked=true<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>Telescope file_browser path=%:p:h<cr>")
vim.keymap.set("n", "<m-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "<m-N>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

vim.keymap.set("i", "<c-b>", "<left>")
vim.keymap.set("i", "<c-f>", "<right>")
vim.keymap.set("i", "<c-a>", "<home>")
vim.keymap.set("i", "<c-e>", "<end>")

vim.keymap.set("c", "<c-b>", "<left>")
vim.keymap.set("c", "<c-f>", "<right>")
vim.keymap.set("c", "<c-a>", "<home>")
vim.keymap.set("c", "<c-e>", "<end>")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
