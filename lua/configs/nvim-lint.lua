local lint = require "lint"

-- PHP configuration
local args = lint.linters.phpstan.args

local get_configuration = function()
  local paths = {
    "phpstan-hq.neon",
  }
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(paths) do
    if vim.loop.fs_stat(cwd .. "/" .. path) then
      return path
    end
  end
end

args = { "analyze", "--no-progress", "--error-format=json" }

local configFile = get_configuration()
if configFile then
  table.insert(args, "--configuration=" .. configFile)
end

lint.linters.phpstan.args = args

-- Configure linters by filetype
lint.linters_by_ft = {
  php = { "phpstan" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  python = { "ruff" },
  go = { "golangcilint" },
  dockerfile = { "hadolint" },
  yaml = { "yamllint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
}

-- Auto-lint on save and file changes
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
