require("jc.lazy").plugin({
  name = "nvim-autopairs",
  lazy = false,
  setup = function()
    require("nvim-autopairs").setup()
  end,
})
