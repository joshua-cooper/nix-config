local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  window = {
    documentation = cmp.config.disable,
  },
  mapping = cmp.mapping.preset.insert({
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})
