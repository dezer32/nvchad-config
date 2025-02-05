local options = {
  -- formatters = {
  -- php_cs_fixer = {},
  -- },
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "fixjson" },
    php = { "php_cs_fixer" },
  },

  format_on_save = {
    --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
