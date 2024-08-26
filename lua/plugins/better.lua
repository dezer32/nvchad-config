return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
     require("better_escape").setup()
    end,
    lazy = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
},
  {
    "okuuva/auto-save.nvim",
    md = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = function ()
      return require("configs.auto-save")
    end,
    lazy = true,
  },
}
