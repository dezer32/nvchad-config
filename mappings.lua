---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.telescope = {
  n = {
    ["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, "Find words"}
  }
}

-- more keybinds!

return M
