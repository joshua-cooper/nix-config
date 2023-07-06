-- Appearance
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.wrap = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Scrolling
vim.opt.scrolloff = 5

-- Mouse
vim.opt.mousemodel = "extend"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Folds
-- vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "getline(v:foldstart) .. ' … ' .. trim(getline(v:foldend))"

-- Indenting
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Completion
vim.opt.completeopt = "menu"

-- Persistent undo
vim.opt.undofile = true

-- Virtual text
vim.opt.fillchars = "fold: ,vert:│,eob:~,msgsep:‾"
vim.opt.listchars = "eol: ,tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"

-- Performance
vim.opt.lazyredraw = true
