return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        -- UI settings
        ui = {
          border = "rounded",
          devicon = true,
          title = true,
          expand = "",
          collapse = "",
          code_action = "💡",
          actionfix = " ",
          lines = { "┗", "┣", "┃", "━", "┏" },
          kind = {},
          imp_sign = "󰳛 ",
        },
        -- Hover settings
        hover = {
          max_width = 0.6,
          max_height = 0.8,
          open_link = "gx",
          open_cmd = "!open",
        },
        -- Diagnostic settings
        diagnostic = {
          show_code_action = true,
          show_layout = "float",
          show_normal_height = 10,
          jump_num_shortcut = true,
          max_width = 0.8,
          max_height = 0.8,
          max_show_width = 0.9,
          max_show_height = 0.6,
          text_hl_follow = true,
          border_follow = true,
          extend_relatedInformation = false,
          diagnostic_only_current = false,
          keys = {
            exec_action = "o",
            quit = "q",
            toggle_or_jump = "<CR>",
            quit_in_show = { "q", "<ESC>" },
          },
        },
        -- Code action settings
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = true,
          keys = {
            quit = "q",
            exec = "<CR>",
          },
        },
        -- Lightbulb settings
        lightbulb = {
          enable = true,
          sign = true,
          debounce = 10,
          sign_priority = 40,
          virtual_text = false,
        },
        -- Scrolling preview
        scroll_preview = {
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        -- Request timeout
        request_timeout = 2000,
        -- Finder settings
        finder = {
          max_height = 0.5,
          left_width = 0.3,
          methods = {},
          default = "ref+imp",
          layout = "float",
          silent = false,
          filter = {},
          fname_sub = nil,
          sp_inexist = false,
          sp_global = false,
          ly_botright = false,
          keys = {
            shuttle = "[w",
            toggle_or_open = "<CR>",
            vsplit = "s",
            split = "i",
            tabe = "t",
            tabnew = "r",
            quit = "q",
            close = "<ESC>",
          },
        },
        -- Definition settings
        definition = {
          width = 0.6,
          height = 0.5,
          save_pos = false,
          keys = {
            edit = "<C-c>o",
            vsplit = "<C-c>v",
            split = "<C-c>i",
            tabe = "<C-c>t",
            tabnew = "<C-c>n",
            quit = "q",
            close = "<C-c>k",
          },
        },
        -- Rename settings
        rename = {
          in_select = true,
          auto_save = false,
          project_max_width = 0.5,
          project_max_height = 0.5,
          keys = {
            quit = "<C-k>",
            exec = "<CR>",
            select = "x",
          },
        },
        -- Symbol in winbar
        symbol_in_winbar = {
          enable = false,
          separator = " › ",
          hide_keyword = false,
          show_file = true,
          folder_level = 1,
          color_mode = true,
          dely = 300,
        },
        -- Outline settings
        outline = {
          win_position = "right",
          win_width = 30,
          auto_preview = true,
          detail = true,
          auto_close = true,
          close_after_jump = false,
          layout = "normal",
          max_height = 0.5,
          left_width = 0.3,
          keys = {
            toggle_or_jump = "<CR>",
            quit = "q",
            jump = "e",
          },
        },
        -- Callhierarchy settings
        callhierarchy = {
          layout = "float",
          left_width = 0.2,
          keys = {
            edit = "e",
            vsplit = "s",
            split = "i",
            tabe = "t",
            close = "<C-c>k",
            quit = "q",
            shuttle = "[w",
            toggle_or_req = "u",
          },
        },
        -- Beacon settings
        beacon = {
          enable = true,
          frequency = 7,
        },
      }

      -- Optional keybindings for LSPSaga
      local keymap = vim.keymap.set
      keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "LSPSaga Outline" })
      keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "LSPSaga Finder" })
      keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSPSaga Peek Definition" })
      keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "LSPSaga Line Diagnostics" })
      keymap("n", "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "LSPSaga Buffer Diagnostics" })
      keymap("n", "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "LSPSaga Workspace Diagnostics" })
      keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "LSPSaga Rename" })
      keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "LSPSaga Incoming Calls" })
      keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "LSPSaga Outgoing Calls" })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
