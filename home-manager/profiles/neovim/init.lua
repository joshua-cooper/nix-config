vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.completeopt = "menu"
vim.opt.mouse = "a"
vim.opt.list = true
vim.opt.wrap = false
vim.opt.listchars = "eol: ,tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.opt.fillchars = "fold: ,vert:│,eob:~,msgsep:‾"
vim.opt.updatetime = 16
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "manual"
vim.opt.termguicolors = true

vim.cmd("colorscheme gruvbox")

vim.keymap.set({ "n", "v" }, "<leader><leader>", ":")
vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("n", "<m-l>", "<c-w>l")
vim.keymap.set("n", "<leader><tab>", "<cmd>buffer #<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm quitall<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>confirm bdelete<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope try_git_files show_untracked=true<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>Telescope file_browser path=%:p:h<cr>")
vim.keymap.set("n", "<m-n>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<m-N>", vim.diagnostic.goto_prev)

vim.keymap.set({ "i", "c" }, "<c-b>", "<left>")
vim.keymap.set({ "i", "c" }, "<c-f>", "<right>")
vim.keymap.set({ "i", "c" }, "<c-a>", "<home>")
vim.keymap.set({ "i", "c" }, "<c-e>", "<end>")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspSettings", {}),
  callback = function(args)
    vim.keymap.set("n", "<leader>c", vim.lsp.codelens.run, { buffer = args.buf })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set("v", "<leader>a", vim.lsp.buf.range_code_action, { buffer = args.buf })
    vim.keymap.set("n", "<leader>i", require("telescope.builtin").lsp_implementations, { buffer = args.buf })
    vim.keymap.set("n", "<leader>r", require("telescope.builtin").lsp_references, { buffer = args.buf })
    vim.keymap.set("n", "<leader>t", require("telescope.builtin").lsp_type_definitions, { buffer = args.buf })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = args.group,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = args.group,
      buffer = args.buf,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
  end,
})

local function is_executable(command)
  return vim.fn.executable(command) == 1
end

local function root_dir(root_files)
  -- return vim.fs.dirname(vim.fs.find(root_files, { path = vim.api.nvim_buf_get_name(0), upward = true  })[1])
  return vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1])
end

local function run_term_command(command)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.fn.termopen(command)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
})

vim.lsp.commands["rust-analyzer.runSingle"] = function(runnable)
  for _, v in ipairs(runnable.arguments) do
    local command = { "cd", v.args.workspaceRoot, "&&", v.kind }
    local command = vim.list_extend(command, v.args.cargoArgs)
    local command = vim.list_extend(command, { "--" })
    local command = vim.list_extend(command, v.args.executableArgs)
    run_term_command(table.concat(command, " "))
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("RustLsp", {}),
  pattern = "rust",
  callback = function()
    if not is_executable("rust-analyzer") then
      return
    end

    local function rust_root_dir()
      if is_executable("cargo") then
        local cargo_toml_dir = root_dir("Cargo.toml")
        local command = { "cargo", "metadata", "--no-deps", "--format-version", "1" }

        if cargo_toml_dir then
          -- TODO: use a path_join function instead of string concat
          command = vim.list_extend(command, { "--manifest-path", cargo_toml_dir .. "/Cargo.toml" })
        end

        local stdout = ""
        local stderr = ""

        local job = vim.fn.jobstart(command, {
          on_stdout = function(_, d, _)
            stdout = table.concat(d, "\n")
          end,
          on_stderr = function(_, d, _)
            stderr = table.concat(d, "\n")
          end,
          stdout_buffered = true,
          stderr_buffered = true,
        })

        if job > 0 then
          job = vim.fn.jobwait({ job })[1]
        else
          job = -1
        end

        if job == 0 then
          local dir = vim.json.decode(stdout)["workspace_root"]

          if dir then
            -- TODO: sanitize dir
            return dir
          end
        else
          vim.notify(
            string.format("[rust-analyzer] command %q failed:\n%s", table.concat(command, " "), stderr),
            vim.log.levels.WARN
          )
        end
      end

      return root_dir({ "Cargo.lock", "rust-project.json" }) or root_dir("Cargo.toml")
    end

    vim.lsp.start({
      name = "rust-analyzer",
      cmd = { "rust-analyzer" },
      root_dir = rust_root_dir(),
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
            command = is_executable("cargo-clippy") and "clippy" or "check",
          },
          lens = {
            debug = {
              enable = false,
            },
            implementations = {
              enable = false,
            },
          },
        },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NixLsp", {}),
  pattern = "nix",
  callback = function()
    if not is_executable("rnix-lsp") then
      return
    end

    vim.lsp.start({
      name = "rnix-lsp",
      cmd = { "rnix-lsp" },
      root_dir = root_dir({ "flake.nix", ".git" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("JavaScriptLsp", {}),
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    if not is_executable("deno") then
      return
    end

    vim.lsp.start({
      name = "deno",
      cmd = { "deno", "lsp" },
      root_dir = root_dir({ "deno.json", "deno.jsonc", ".git" }),
      init_options = {
        enable = true,
        unstable = false,
      },
    })
  end,
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
})

require("treesitter-context").setup({
  enable = true,
})

require("Comment").setup()

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

require("telescope").load_extension("try_git_files")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")

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
