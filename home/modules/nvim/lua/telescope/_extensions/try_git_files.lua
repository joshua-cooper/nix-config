return require("telescope").register_extension({
  exports = {
    try_git_files = function(opts)
      local ok = pcall(require("telescope.builtin").git_files, opts)
      if not ok then
        require("telescope.builtin").find_files(opts)
      end
    end,
  },
})
