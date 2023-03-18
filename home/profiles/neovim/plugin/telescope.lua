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
    preview = {
      filesize_limit = 0.5,
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

vim.cmd.packadd("telescope-fzf-native.nvim")
vim.cmd.packadd("telescope-ui-select.nvim")

require("telescope").load_extension("try_git_files")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
