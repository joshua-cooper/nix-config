vim.bo.tabstop = 4

local root_dir = jc.root_dir({ "Cargo.lock", "rust-project.json" }) or jc.root_dir("Cargo.toml")

if root_dir and jc.is_executable("rust-analyzer") then
  vim.lsp.start({
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    root_dir = root_dir,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
        rustfmt = {
          rangeFormatting = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          command = jc.is_executable("cargo-clippy") and "clippy" or "check",
        },
      },
    },
  })
end
