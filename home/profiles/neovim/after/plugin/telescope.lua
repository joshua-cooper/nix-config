local runners = require("jc.runners")
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")

local actions = {
  git_show = function(buf)
    -- TODO: Open in another split.
    local commit_hash = action_state.get_selected_entry().value
    vim.cmd.Git(string.format("show %s", commit_hash))
  end,
}

telescope.setup({
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
    border = true,
    results_title = false,
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
    git_files = {
      show_untracked = true,
    },
    git_commits = {
      mappings = {
        i = {
          ["<cr>"] = actions.git_show,
        },
        n = {
          ["<cr>"] = actions.git_show,
        },
      },
    },
    git_bcommits = {
      mappings = {
        i = {
          ["<cr>"] = actions.git_show,
        },
        n = {
          ["<cr>"] = actions.git_show,
        },
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("try_git_files")

vim.keymap.set("n", "<leader>f", "<cmd>Telescope try_git_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>F", function()
  runners.on_input("Regex: ", function(input)
    builtin.grep_string({
      search = input,
      use_regex = true,
    })
  end)
end, { desc = "Find regex" })

vim.keymap.set("n", "<leader>d", function()
  builtin.diagnostics({
    severity_limit = vim.diagnostic.severity.WARN,
  })
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "Git buffer commits" })
vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gs", builtin.git_stash, { desc = "Git stash" })
