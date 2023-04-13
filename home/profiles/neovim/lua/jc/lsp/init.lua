local utils = require("jc.utils")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspSettings", {}),
  callback = function(args)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = args.buf })
    vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = args.buf })

    vim.keymap.set("n", "<leader>lr", function()
      vim.cmd.Telescope("lsp_references")
    end, { buffer = args.buf })

    vim.keymap.set("n", "<leader>lt", function()
      vim.cmd.Telescope("lsp_type_definitions")
    end, { buffer = args.buf })

    vim.keymap.set("n", "<leader>li", function()
      vim.cmd.Telescope("lsp_implementations")
    end, { buffer = args.buf })

    vim.keymap.set("n", "<leader>ls", function()
      utils.on_input("Workspace symbol: ", function(input)
        vim.cmd.Telescope("lsp_workspace_symbols", ("query=%s"):format(input))
      end)
    end, { buffer = args.buf })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = args.group,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
})
