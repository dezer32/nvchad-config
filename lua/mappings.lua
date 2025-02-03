require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map("n", "<leader>li", function()
  -- require("telescope.builtin").lsp_implementations()
-- end, { desc = "LSP Implementations (Telescope)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
