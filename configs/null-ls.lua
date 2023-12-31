local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- php
  -- b.formatting.phpactor,
  b.formatting.phpcsfixer.with {
    args = { "--no-interaction", "--quiet", "fix", "$FILENAME", "--using-cache=no" },
  },
  -- b.formatting.phpcsfixer,
  -- twig
  -- go
  b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,
  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- markdown
  -- b.formatting.markdownlint,
  b.diagnostics.markdownlint,
  -- another
  -- b.formatting.ansible_lint,
  b.diagnostics.ansible_lint,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
