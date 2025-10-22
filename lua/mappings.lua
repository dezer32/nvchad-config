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
map("n", "<leader>fc", function()
  require("fzf-lua").lsp_live_workspace_symbols {
    prompt = "Find class ❯ ",
    async = false,
    -- Array = 18,
    -- Boolean = 17,
    -- Class = 5,
    -- Constant = 14,
    -- Constructor = 9,
    -- Enum = 10,
    -- EnumMember = 22,
    -- Event = 24,
    -- Field = 8,
    -- File = 1,
    -- Function = 12,
    -- Interface = 11,
    -- Key = 20,
    -- Method = 6,
    -- Module = 2,
    -- Namespace = 3,
    -- Null = 21,
    -- Number = 16,
    -- Object = 19,
    -- Operator = 25,
    -- Package = 4,
    -- Property = 7,
    -- String = 15,
    -- Struct = 23,
    -- TypeParameter = 26,
    -- Variable = 13
  }
end)
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
-- map("n", "<leader>ca", fzf.lsp_code_actions, { noremap = true, silent = true, desc = "FZF code action" })

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

-- DAP (Debugger)
local dap_ok, dap = pcall(require, "dap")
if dap_ok then
  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
  map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  end, { desc = "DAP Conditional Breakpoint" })
  map("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
  map("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
  map("n", "<leader>do", dap.step_over, { desc = "DAP Step Over" })
  map("n", "<leader>dO", dap.step_out, { desc = "DAP Step Out" })
  map("n", "<leader>dr", dap.repl.toggle, { desc = "DAP Toggle REPL" })
  map("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
  map("n", "<leader>dt", dap.terminate, { desc = "DAP Terminate" })

  local dapui_ok, dapui = pcall(require, "dapui")
  if dapui_ok then
    map("n", "<leader>du", dapui.toggle, { desc = "DAP Toggle UI" })
    map("n", "<leader>de", dapui.eval, { desc = "DAP Eval" })
  end
end
