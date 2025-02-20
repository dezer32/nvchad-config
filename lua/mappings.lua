require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

map("n", "[b", "<cmd> bprevious <cr>", { desc = "Prevous buffer" })
map("n", "]b", "<cmd> bnext <cr>", { desc = "Next buffer" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n" }, "<leader>w", "<cmd> w <cr>")

-- fzf-lua
local fzf = require "fzf-lua"
map("n", "<leader>gs", fzf.lsp_document_symbols, { noremap = true, silent = true, desc = "FZF document symbols" })
map("n", "<leader>fb", fzf.buffers, { noremap = true, silent = true, desc = "FZF Buffers" })
map("n", "<leader>ff", fzf.files, { noremap = true, silent = true, desc = "FZF Files" })
map("n", "<leader>fa", function()
  fzf.files {
    formatter = "path.filename_first",
    follow = true,
    no_ignore = true,
  }
end, { noremap = true, silent = true, desc = "FZF All files" })
map("n", "<leader>fw", fzf.live_grep, { noremap = true, silent = true, desc = "FZF live grep" })
map("n", "<leader>gb", fzf.git_blame, { noremap = true, silent = true, desc = "FZF git blame" })
map("n", "<leader>gc", fzf.git_commits, { noremap = true, silent = true, desc = "FZF git commits" })

-- Spectre
local spectre = require "spectre"
map("n", "<leader>rr", spectre.toggle, { desc = "Toggle Spectre" })
map("v", "<leader>rw", spectre.open_visual, { desc = "Search current word" })
map("n", "<leader>rw", spectre.open_visual, { desc = "Toggle Visaal Spectre" })
map("n", "<leader>rp", spectre.open_file_search, { desc = "Toggle Visaal Spectre" })

-- Terminal
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })
