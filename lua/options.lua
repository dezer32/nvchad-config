require "nvchad.options"

require "configs.snippets"

-- Performance optimizations
-- Disable unused providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Enable Lua bytecode caching (Neovim 0.9+)
if vim.loader then
  vim.loader.enable()
end

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.scrolloff = 20

-- Disable LSP for large files (> 1MB)
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand "%")
    if file_size > 1024 * 1024 then -- 1MB
      vim.notify("File is too large, disabling LSP and syntax", vim.log.levels.WARN)
      vim.cmd "syntax clear"
      vim.schedule(function()
        vim.cmd "LspStop"
      end)
    end
  end,
})
