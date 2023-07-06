local luasnip = require("luasnip")

luasnip.setup({
  history = true,
})

require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/jc/snippets" })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.jump(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)
