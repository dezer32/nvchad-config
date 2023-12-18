local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    --
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    --
    "c",
    "php",
    "go",
    --
    "markdown",
    "markdown_inline",
    "twig",
    -- "ansible",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "selene",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- php
    "phpactor",
    -- "phpcsfixer",
    "php-cs-fixer",
    "phpstan",
    "php-debug-adapter",

    -- go
    "gopls",
    "gofumpt",
    "goimports-reviser",
    "golangci-lint",
    "golines",
    "delve",

    -- ansible
    "ansible-language-server",
    "ansible-lint",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
