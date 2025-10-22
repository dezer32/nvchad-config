local options = {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },
    -- Web
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    -- JavaScript/TypeScript
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    -- PHP
    php = { "php_cs_fixer" },
    -- Python
    python = { "black", "isort" },
    -- Go
    go = { "gofumpt", "goimports" },
    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
