return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {
    files = {
      previewer = "bat",
      formatter = "path.filename_first",
      -- path_shorten = 5,
      -- cwd_prompt = false,
    },
    winopts = {
      preview = {
        horizontal = "right:45%",
      },
    },
  },
}
