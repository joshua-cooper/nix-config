require("jc.lazy").plugin({
  name = "nvim-surround",
  lazy = false,
  setup = function()
    require("nvim-surround").setup()
  end,
})
