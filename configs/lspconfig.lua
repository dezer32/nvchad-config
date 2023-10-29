local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
-- local servers = { "html", "css", "tsserver" }
local servers = { "selene", "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotoml" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      goimports = true,
    },
  },
}

lspconfig.phpactor.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- cmd = { "phpactor" },
  init_options = {
    ["language_server_psalm.enabled"] = false,
    ["language_server_phpstan.enabled"] = true,
    ["language_server_php_cs_fixer.enabled"] = true,
    ["symfony.enabled"] = true,
    ["phpunit.enabled"] = true,
  },
}
