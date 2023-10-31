local Terminal = require("toggleterm.terminal").Terminal

local zsh = Terminal:new {
  hidden = true,
}

local lazygit = Terminal:new {
  cmd = "lazygit",
  hidden = true,
}

function _terminal_zsh_toggle()
  zsh.toggle()
end

function _terminal_lazygit_toggle()
  lazygit.toggle()
end


