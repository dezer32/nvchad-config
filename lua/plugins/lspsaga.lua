return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        -- при желании тут кастомная конфигурация
      })

      -- local keymap = vim.keymap.set
      -- keymap("n", "<leader>fd", "<cmd>Lspsaga finder <CR>", {desc = "Lspsaga Finder"})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    },
  }
}
