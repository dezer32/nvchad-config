local lint = require "lint"

local args = lint.linters.phpstan.args

local get_configuration = function ()
  local paths = {
    "phpstan-hq.neon"
  }
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(paths) do
    if vim.loop.fs_stat(cwd ..'/'.. path) then
      return path
    end
  end
end


args = {'analyze', '--no-progress', '--error-format=json'}

local configFile = get_configuration()
if configFile then
  table.insert(args, "--configuration="..configFile)
end

lint.linters.phpstan.args = args

lint.linters_by_ft = {
  php = { "phpstan" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
