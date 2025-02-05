local lint = require "lint"

-- lint.listeners.phpstan = {}

lint.linters_by_ft = {
  php = { "phpstan" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
