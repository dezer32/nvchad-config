local Terminal = require("toggleterm.terminal").Terminal

local zsh = Terminal:new {
  float_opts = {
    height = 45,
    width = 150,
  },
  hidden = true,
  direction = "float",
}

local lazygit = Terminal:new {
  cmd = "lazygit",
  -- size = 40,
  hidden = true,
  direction = "float",
}

return {
  _term_toggle_lazygit = function()
    lazygit:toggle()
  end,

  _term_toggle_zsh = function()
    zsh:toggle()
  end,
}
