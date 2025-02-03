return {
  {
    {
      "nvim-pack/nvim-spectre",
      event = "VeryLazy",
      config = function()
        require("spectre").setup {
          live_update = true,
          mapping = {
            ["toggle"] = {
              map = "<leader>rr",
              cmd = '<cmd>lua require("spectre").toggle()<CR>',
              desc = "Toggle",
            },
            ["esc"] = {
              map = "<esc>",
              cmd = '<cmd>lua require("spectre").toggle()<CR>',
              desc = "Toggle",
            },
            ["q"] = {
              map = "q",
              cmd = '<cmd>lua require("spectre").toggle()<CR>',
              desc = "Toggle",
            },
          },
          replace_engine = {
            ["sed"] = {
              cmd = "gsed",
              args = nil,
              options = {
                ["ignore-case"] = {
                  value = "--ignore-case",
                  icon = "[I]",
                  desc = "ignore case",
                },
              },
            },
          },
        }
      end,
    },
  },
}
