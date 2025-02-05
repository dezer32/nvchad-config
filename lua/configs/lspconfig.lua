-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "lua_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

local overridedOnAttach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  local s = vim.keymap.set
  local fzf = require "fzf-lua"
  s("n", "gi", fzf.lsp_implementations, { buffer = bufnr, noremap = true, silent = true, desc = "FZF implementations" })
  s("n", "gr", fzf.lsp_references, { buffer = bufnr, noremap = true, silent = true, desc = "FZF references" })
  s("n", "gd", fzf.lsp_definitions, { buffer = bufnr, noremap = true, silent = true, desc = "FZF definitions" })
  s("n", "gD", fzf.lsp_declarations, { buffer = bufnr, noremap = true, silent = true, desc = "FZF declarations" })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = overridedOnAttach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = overridedOnAttach,
  capabilities = nvlsp.capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        },
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
}

local get_intelephense_license = function()
  local f = assert(io.open(os.getenv "HOME" .. "/.intelephense", "rb"))
  local content = f:read "*a"
  f:close()
  return string.gsub(content, "%s+", "")
end

lspconfig.intelephense.setup {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  init_options = {
    licenceKey = get_intelephense_license(),
  },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
