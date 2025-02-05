return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      -- map("n", "<leader>li", function()
      -- actionslsp_implementations()
      -- end, { desc = "LSP Implementations (Telescope)" })

      local actions = require "telescope.actions"
      local builtin = require "telescope.builtin"

      conf.defaults.mappings.i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<Esc>"] = actions.close,
      }

      local get_telescope_ignore = function()
        local f = assert(io.open(vim.fn.getcwd() .. "/.telescope_ignore", "rb"))
        -- local f = io.open(vim.fn.getcwd() .. "/.telescope_ignore", "rb")

        local arr = {}
        if f then
          for line in f:lines() do
            table.insert(arr, line)
          end
          f:close()
        end

        return arr
      end

      conf.defaults.file_ignore_patterns = get_telescope_ignore()

      -- or
      -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  },
}
