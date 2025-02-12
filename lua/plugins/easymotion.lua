return {
  "easymotion/vim-easymotion",
  lazy = false, -- Загружать сразу при старте Neovim
  config = function()
    vim.g.EasyMotion_leader_key = "<leader>"
    vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-s)", {})

    -- vim.api.nvim_set_keymap('n', '<Leader>w', '<Plug>(easymotion-w)', {})
    -- vim.api.nvim_set_keymap("n", "<leader>e", "<Plug>(easymotion-e)", {})
    vim.api.nvim_set_keymap("n", "<leader>f", "<Plug>(easymotion-f)", {})
    vim.api.nvim_set_keymap("n", "<leader>j", "<Plug>(easymotion-j)", {})
    vim.api.nvim_set_keymap("n", "<leader>k", "<Plug>(easymotion-k)", {})
  end,
}
