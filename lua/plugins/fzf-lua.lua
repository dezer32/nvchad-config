local get_fzf_ignore = function()
  -- local f = assert(io.open(vim.fn.getcwd() .. "/.telescope_ignore", "rb"))
  local f = io.open(vim.fn.getcwd() .. "/.nvimignore", "rb")

  local arr = {}
  if f then
    for line in f:lines() do
      table.insert(arr, line)
    end
    f:close()
  end

  return arr
end

local get_fzf_ignore_file = function()
  local ignore_file = vim.fn.getcwd() .. "/.nvimignore"
  if not vim.loop.fs_stat(ignore_file) then
    return
  end

  return ignore_file
end

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
      -- cmd = "fd -p",
      -- fd_opts = [[--color=never --hidden --type f --type l --exclude .git -p]],
    },
    lsp = {
      -- previewer = "bat",
      jump_to_single_result = true,
      formatter = "path.filename_first",
      cwd_only = true,
      finder = {
        -- previewer = "bat",
        formatter = "path.filename_first",
        jump_to_single_result = true,
      },
    },
    winopts = {
      preview = {
        horizontal = "right:45%",
      },
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    -- require("fzf-lua").setup { "fzf-native" }
    -- require("fzf-lua").setup {
    --   "fzf-native",
    --   files = {
    --     -- previewer = "bat",
    --     formatter = "path.filename_first",
    --     -- path_shorten = 5,
    --     -- cwd_prompt = false,
    --   },
    --   lsp = {
    --     -- previewer = "bat",
    --     jump_to_single_result = true,
    --     formatter = "path.filename_first",
    --     cwd_only = true,
    --     finder = {
    --       -- previewer = "bat",
    --       formatter = "path.filename_first",
    --       jump_to_single_result = true,
    --     },
    --   },
    --   winopts = {
    --     preview = {
    --       horizontal = "right:45%",
    --     },
    --   },
    -- }
  end,
}
