-- TODO: Remove duplication between all variants of JS

vim.bo.tabstop = 2

local function server()
  local have_deno = jc.is_executable("deno")
  local have_tsserver = jc.is_executable("typescript-language-server")
  local deno_root_dir = jc.root_dir({ "deno.json", "deno.jsonc" })
  local node_root_dir = jc.root_dir({ "package.json" })

  if have_deno and deno_root_dir then
    return "deno"
  end

  if have_tsserver and node_root_dir then
    return "tsserver"
  end

  if have_deno then
    return "deno"
  end

  if have_tsserver then
    return "tsserver"
  end
end

local servers = {}

function servers.deno()
  vim.lsp.start({
    name = "deno",
    cmd = { "deno", "lsp" },
    root_dir = jc.root_dir({ "deno.json", "deno.jsonc", ".git" }) or vim.fn.getcwd(),
    init_options = {
      enable = true,
      unstable = false,
    },
  })
end

function servers.tsserver()
  vim.lsp.start({
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = jc.root_dir({ "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "pnpm-workspace.yaml", ".git" })
      or jc.root_dir("package.json")
      or vim.fn.getcwd(),
    init_options = {
      hostInfo = "neovim",
    },
  })
end

local start_server = servers[server()]

if start_server then
  start_server()
end
