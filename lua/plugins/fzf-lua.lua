return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {
    files = {
      -- previewer = "bat",
      formatter = "path.filename_first",
      -- path_shorten = 5,
      -- cwd_prompt = false,
    },
    lsp = {
      -- previewer = "bat",
      formatter = "path.filename_first",
      cwd_only = true,
      finder = {
        -- previewer = "bat",
        formatter = "path.filename_first",
      },
    },
    winopts = {
      preview = {
        horizontal = "right:45%",
      },
    },
  },
}
