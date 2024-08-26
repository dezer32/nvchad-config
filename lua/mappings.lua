require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


-- Terminal
map({"n", "t"}, "<C-t>", function ()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm"}
end, {desc = "Terminal Toggle Floating term"})

-- map({"n", "t"}, "<A-g>", function ()
--   require("nvchad.term").toggle { pos = "float", id = "lazygit", clear_cmd = false, cmd = "lazygit"}
-- end, {desc = "Terminal Toggle Floating term"})
