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

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  local s = vim.keymap.set

  -- Navigation with LSPSaga
  s("n", "ga", "<cmd>Lspsaga finder<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Finder (All)" })
  s("n", "gi", "<cmd>Lspsaga finder imp<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Implementations" })
  s("n", "gr", "<cmd>Lspsaga finder ref<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga References" })
  s("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Goto Definition" })
  s("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Peek Definition" })
  s("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Type Definition" })

  -- Documentation and help with LSPSaga
  s("n", "K", "<cmd>Lspsaga hover_doc<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Hover Doc" })
  s("n", "<C-k>", function()
    vim.lsp.buf.signature_help { focusable = false, border = "rounded" }
  end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP Signature Help" })
  s("i", "<C-k>", function()
    vim.lsp.buf.signature_help { focusable = false, border = "rounded" }
  end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP Signature Help" })

  -- Code actions with LSPSaga
  s("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Code Actions" })
  s("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Code Actions" })

  -- Diagnostics with LSPSaga
  s("n", "<leader>ds", "<cmd>Lspsaga show_buf_diagnostics<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Buffer Diagnostics" })
  s("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Workspace Diagnostics" })
  s("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Previous Diagnostic" })
  s("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Next Diagnostic" })
  s("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Line Diagnostics" })

  -- Call hierarchy with LSPSaga
  s("n", "<leader>ic", "<cmd>Lspsaga incoming_calls<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Incoming Calls" })
  s("n", "<leader>oc", "<cmd>Lspsaga outgoing_calls<CR>", { buffer = bufnr, noremap = true, silent = true, desc = "LSPSaga Outgoing Calls" })

  -- Inlay hints toggle
  if vim.lsp.inlay_hint then
    s("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
    end, { buffer = bufnr, noremap = true, silent = true, desc = "Toggle Inlay Hints" })
  end
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

-- Configure enhanced diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = "",
  },
}

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

-- Enhanced configurations for specific servers with custom settings

-- TypeScript/JavaScript with inlay hints
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

-- Python with type checking
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

-- Go with static check and gofumpt
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
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

-- JSON with schemas
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

-- YAML with Kubernetes schemas
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
