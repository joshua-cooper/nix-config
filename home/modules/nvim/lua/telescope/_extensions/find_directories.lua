return require("telescope").register_extension({
  exports = {
    find_directories = function(opts)
      require("telescope.pickers").new(opts, {
        prompt_title = "Find Directories",
        finder = require("telescope.finders").new_oneshot_job({
          "fd",
          "--strip-cwd-prefix",
          "--type",
          "d",
          "--hidden",
          "--exclude",
          ".git",
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        previewer = require("telescope.config").values.file_previewer(opts),
      }):find()
    end,
  },
})
