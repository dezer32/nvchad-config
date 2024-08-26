local conf = require("nvchad.configs.telescope")
local actions = require("telescope.actions")

conf.defaults.mappings.i = {
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<Esc>"] = actions.close,
}

return conf
