require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_size = 500 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_size then
        return true
      end
    end,
  },
  indent = {
    enable = false,
  },
})
