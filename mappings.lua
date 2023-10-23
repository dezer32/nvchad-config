---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>w"] = { "<cmd>w!<CR>", "Save" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["<leader>w"] = { "<cmd>w!<CR>", "Save" },
  },
}

M.telescope = {
  n = {
    ["<leader>fw"] = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "Live grep",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        }
      end,
      "Live grep in all files",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    L = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    H = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.nvterm = {
  plugin = true,
  n = {
    ["<f7>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
    },
  },
  t = {
    ["<f7>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
    },
  },
}

M.goimpl = {
  -- plugin = true,
  n = {
    ["<leader>gi"] = {
      function()
        require("telescope").extensions.goimpl.goimpl {}
      end,
      "Implement interface",
    },
  },
}

M.hop = {
  -- plugin = true,
  n = {
    f = {
      function()
        require("hop").hint_char1 { current_line_only = true }
      end,
    },
    F = {
      function()
        require("hop").hint_char1()
      end,
    },
    ["<leader>fj"] = {
      function()
        require("hop").hint_lines_skip_whitespace { direction = require("hop.hint").HintDirection.AFTER_CURSOR }
      end,
      -- "<cmd> HopLineStartAC <CR>",
    },
    ["<leader>fk"] = {
      function()
        require("hop").hint_lines_skip_whitespace { direction = require("hop.hint").HintDirection.BEFORE_CURSOR }
      end,
      -- "<cmd> HopLineStartBC <CR>",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoing at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_lats()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml tags",
    },
  },
}

M.phpactor = {
  plugin = true,
  n = {
    ["<leader>pcc"] = {
      '<cmd> call phpactor#rpc("class_new", { "current_path": phpactor#_path(), "variant": "default"}) <CR>',
      "PHP Create class",
    },
    ["<leader>pci"] = {
      '<cmd> call phpactor#rpc("class_new", { "current_path": phpactor#_path(), "variant": "interface"}) <CR>',
      "PHP Create interface",
    },
  },
}
-- more keybinds!

return M
