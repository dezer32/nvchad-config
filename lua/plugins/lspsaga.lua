--[[
LSPSaga Configuration

Preview Scrolling Guide:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
In Finder Window (ga, gr, gi, gh):
  1. Press [w to SWITCH between list panel and preview panel
  2. When focused on PREVIEW panel (right side):
    • j / k       - Scroll down/up line by line (natural vim movement)
    • <C-d> / <C-u> - Scroll down/up half page
    • <C-f> / <C-b> - Scroll down/up full page

In Hover Window (K):
  • j / k       - Scroll down/up line by line
  • <C-f> / <C-b> - Scroll down/up full page

In Definition Preview (gp, gD, gP):
  • <C-f> / <C-b> - Scroll down/up full page
  • Use arrow keys or vim motions (j/k) for navigation

⚡ Key Point: In Finder, press [w to switch to preview, then use j/k!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--]]

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
          -- Enable mouse support for better interaction
          winblend = 0,
        },
        -- Hover settings - Enhanced for better documentation view
        hover = {
          max_width = 0.8,  -- Wider for detailed documentation
          max_height = 0.8,
          open_link = "gx",
          open_cmd = "!open",
          -- Scrolling within hover window
          -- Use <C-f> and <C-b> to scroll
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
        -- Scrolling preview - Enhanced with multiple options
        scroll_preview = {
          scroll_down = "<C-f>",  -- Page down in preview
          scroll_up = "<C-b>",    -- Page up in preview
        },
        -- Request timeout
        request_timeout = 2000,
        -- Finder settings - Enhanced for better visibility
        finder = {
          max_height = 0.7,  -- Increased height for better visibility
          left_width = 0.35,  -- Wider left panel
          right_width = 0.65,  -- Wider right panel for preview
          methods = {},
          default = "ref+imp+def",  -- Show references, implementations, and definitions
          layout = "float",
          silent = false,
          filter = {},
          fname_sub = nil,
          sp_inexist = false,
          sp_global = false,
          ly_botright = false,
          keys = {
            shuttle = "[w",  -- Switch between list and preview panel
            toggle_or_open = "<CR>",
            vsplit = "s",
            split = "i",
            tabe = "t",
            tabnew = "r",
            quit = "q",
            close = "<ESC>",
            -- Preview scrolling when focused on preview panel
            scroll_down = "<C-f>",  -- Scroll preview down (full page)
            scroll_up = "<C-b>",    -- Scroll preview up (full page)
          },
          -- NOTE: For line-by-line scrolling in preview, use j/k after switching to preview with [w
        },
        -- Definition settings - Enhanced size
        definition = {
          width = 0.8,  -- Larger width for better code visibility
          height = 0.6,  -- Taller for more context
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
        -- Rename settings - Enhanced size
        rename = {
          in_select = true,
          auto_save = false,
          project_max_width = 0.7,  -- Wider for better project view
          project_max_height = 0.6,  -- Taller for more results
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

      -- Global keybindings for LSPSaga
      local keymap = vim.keymap.set

      -- Outline and Finder
      keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "LSPSaga Outline" })
      keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "LSPSaga Finder" })

      -- Peek definition (preview without jumping)
      keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSPSaga Peek Definition" })
      keymap("n", "gP", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "LSPSaga Peek Type Definition" })

      -- Diagnostics
      keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "LSPSaga Line Diagnostics" })
      keymap("n", "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "LSPSaga Buffer Diagnostics" })
      keymap("n", "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "LSPSaga Workspace Diagnostics" })

      -- Rename with project-wide preview
      keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "LSPSaga Rename" })
      keymap("n", "<leader>rp", "<cmd>Lspsaga rename ++project<CR>", { desc = "LSPSaga Project Rename" })

      -- Call hierarchy
      keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "LSPSaga Incoming Calls" })
      keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "LSPSaga Outgoing Calls" })

      -- Terminal toggle
      keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", { desc = "LSPSaga Toggle Terminal" })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
