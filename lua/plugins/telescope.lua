return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)

      -- map("n", "<leader>li", function()
  -- require("telescope.builtin").lsp_implementations()
-- end, { desc = "LSP Implementations (Telescope)" })


      conf.defaults.mappings.i = {
        ["<C-k>"] = require("telescope.actions").move_selection_prev,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
        ["<leader>gi"] = require("telescope.builtin").lsp_implementations
      }

     -- or 
     -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  }
}
