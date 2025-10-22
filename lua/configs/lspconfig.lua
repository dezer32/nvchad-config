-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- LSP servers to configure
local servers = {
  "html",
  "cssls",
  "ts_ls", -- TypeScript/JavaScript
  "pyright", -- Python
  "gopls", -- Go
  "jsonls", -- JSON
  "yamlls", -- YAML
  "dockerls", -- Dockerfile
  "docker_compose_language_service", -- Docker Compose
}
local nvlsp = require "nvchad.configs.lspconfig"

local overridedOnAttach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  -- Attach navic for breadcrumbs
  if client.server_capabilities.documentSymbolProvider then
    local navic_ok, navic = pcall(require, "nvim-navic")
    if navic_ok then
      navic.attach(client, bufnr)
    end
  end

  local s = vim.keymap.set
  local fzf = require "fzf-lua"
  s("n", "ga", fzf.lsp_finder, { buffer = bufnr, noremap = true, silent = true, desc = "FZF finder" })
  s("n", "gi", fzf.lsp_implementations, { buffer = bufnr, noremap = true, silent = true, desc = "FZF implementations" })
  s("n", "gr", fzf.lsp_references, { buffer = bufnr, noremap = true, silent = true, desc = "FZF references" })
  s("n", "gd", fzf.lsp_definitions, { buffer = bufnr, noremap = true, silent = true, desc = "FZF definitions" })
  s("n", "gD", fzf.lsp_declarations, { buffer = bufnr, noremap = true, silent = true, desc = "FZF declarations" })
  s("n", "gt", fzf.lsp_typedefs, { buffer = bufnr, noremap = true, silent = true, desc = "FZF declarations" })

  s(
    "n",
    "<leader>ca",
    fzf.lsp_code_actions,
    { buffer = bufnr, noremap = true, silent = true, desc = "FZF code action" }
  )
  s(
    "n",
    "<leader>ds",
    fzf.diagnostics_document,
    { buffer = bufnr, noremap = true, silent = true, desc = "FZF code action" }
  )
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = overridedOnAttach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp)
end

vim.lsp.config("lua_ls", {
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
})
vim.lsp.enable("lua_ls")

local get_intelephense_license = function()
  local f = assert(io.open(os.getenv "HOME" .. "/.intelephense", "rb"))
  local content = f:read "*a"
  f:close()
  return string.gsub(content, "%s+", "")
end

vim.lsp.config("intelephense", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    licenceKey = get_intelephense_license(),
  },
})
vim.lsp.enable("intelephense")

-- TypeScript/JavaScript LSP
vim.lsp.config("ts_ls", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})
vim.lsp.enable("ts_ls")

-- Python LSP
vim.lsp.config("pyright", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable("pyright")

-- Go LSP
vim.lsp.config("gopls", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable("gopls")

-- JSON LSP with schemas
vim.lsp.config("jsonls", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable("jsonls")

-- YAML LSP with Kubernetes schemas
vim.lsp.config("yamlls", {
  on_attach = overridedOnAttach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("schemastore").yaml.schemas(),
      format = {
        enable = true,
      },
      validate = true,
    },
  },
})
vim.lsp.enable("yamlls")
