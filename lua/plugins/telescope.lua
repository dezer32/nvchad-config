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

      conf.defaults.mappings.n = {
        ["gi"] = builtin.lsp_implementations,
        ["gr"] = builtin.lsp_references,
      }

      -- or
      -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  },
}
