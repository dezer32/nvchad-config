require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

map ("n", "[b", "<cmd> bprevious <cr>", {desc="Prevous buffer"})
map ("n", "]b", "<cmd> bnext <cr>", {desc="Next buffer"})

-- map("n", "<leader>li", function()
-- require("telescope.builtin").lsp_implementations()
-- end, { desc = "LSP Implementations (Telescope)" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n" }, "<leader>w", "<cmd> w <cr>")

-- Telescope
local telescope = require "telescope.builtin"
map("n", "<leader>gi", telescope.lsp_implementations, { desc = "Telescope LSP Implementations" })
map("n", "<leader>gr", telescope.lsp_references, { desc = "Telescope LSP Implementations", remap = false })

-- fzf-lua
local fzf = require "fzf-lua"
map("n", "<leader>fb", fzf.buffers, { noremap = true, silent = true, desc = "FZF Buffers" })
map("n", "<leader>ff", fzf.files, { noremap = true, silent = true, desc = "FZF Files" })
map("n", "<leader>fa", function()
  fzf.files {
    previewer = "bat",
    formatter = "path.filename_first",
    follow = true,
    no_ignore = true,
  }
end, { noremap = true, silent = true, desc = "FZF All files" })

-- Spectre
local spectre = require "spectre"
map("n", "<leader>rr", spectre.toggle, { desc = "Toggle Spectre" })
map("v", "<leader>rw", spectre.open_visual, { desc = "Search current word" })
map("n", "<leader>rw", spectre.open_visual, { desc = "Toggle Visaal Spectre" })
map("n", "<leader>rp", spectre.open_file_search, { desc = "Toggle Visaal Spectre" })
