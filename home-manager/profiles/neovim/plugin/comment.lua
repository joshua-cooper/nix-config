require("jc.lazy").plugin({
  name = "comment.nvim",
  lazy = false,
  setup = function()
    require("Comment").setup()
  end,
})
