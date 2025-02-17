return {
  "easymotion/vim-easymotion",
  lazy = false, -- Загружать сразу при старте Neovim
  config = function()
    vim.g.EasyMotion_leader_key = "<leader>"
    vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s)", {})

    -- vim.api.nvim_set_keymap('n', '<Leader>w', '<Plug>(easymotion-w)', {})
    -- vim.api.nvim_set_keymap("n", "<leader>e", "<Plug>(easymotion-e)", {})
    -- vim.api.nvim_set_keymap("n", "<leader>ff", "<Plug>(easymotion-f)", {})
    -- vim.api.nvim_set_keymap("n", "<leader>fj", "<Plug>(easymotion-j)", {})
    -- vim.api.nvim_set_keymap("n", "<leader>fk", "<Plug>(easymotion-k)", {})
  end,
}
