local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = require "custom.configs.telescope",
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- require "custom.configs.toggletermconfig"
      require("core.utils").load_mappings "toggleterm"
    end,
    lazy = true,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        default = true,
        strict = true,
        color_icons = true,
      }
    end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
    lazy = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
    lazy = true,
  },

  -- {
  --   "kdheepak/lazygit.nvim",
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },

  -- {
  --   "friendsoftwig/twigcs",
  --   ft = "twig",
  -- },

  -- Debug
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim", lazy = true },
    },
    init = function()
      require("telescope").load_extension "dap"
      require("core.utils").load_mappings "dap"
    end,
    lazy = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
    opts = function()
      return require "custom.configs.dapuiconfig"
    end,
    config = function(_, opts)
      require("dapui").setup(opts)
      require("core.utils").load_mappings "dapui"
    end,
    lazy = true,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end,
    lazy = true,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
    lazy = true,
  },

  -- Go
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
    lazy = true,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "edolphin-ydf/goimpl.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("telescope").load_extension "goimpl"
      require("core.utils").load_mappings "goimpl"
    end,
    lazy = true,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    config = function(_, opts)
      require("hop").setup(opts)
    end,
  },
  {
    "okuuva/auto-save.nvim",
    md = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      execution_message = {
        enabled = true,
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S")
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
      trigger_events = { -- See :h events
        immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
      },
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      -- if set to `nil` then no specific condition is applied
      condition = nil,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      noautocmd = false, -- do not execute autocmds when saving
      -- debounce_delay = 1000, -- delay after which a pending save is executed
      debounce_delay = 5000, -- delay after which a pending save is executed
      -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false,

      -- your config goes here
      -- or just leave it empty :)
    },
    lazy = true,
  },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function(_, opts)
  --     require("go").setup(opts)
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  {
    "phpactor/phpactor",
    ft = "php",
    config = function()
      -- require("phpactor").setup(opts)
      require("core.utils").load_mappings "phpactor"
    end,
    lazy = true,
  },

  -- {
  --k  "stephpy/vim-php-cs-fixer",
  --   ft = "php",
  --   opts = {
  --     php_cs_fixer_path = "./vendor/bin/php-cs-fixer",
  --   },
  --   -- config = function(_, opts)
  --   --   require("vim-php-cs-fixer").setup(opts)
  --   -- end,
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-phpunit",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-phpunit" {
            filter_dirs = { ".git", "node_modules", "vendro" },
          },
        },
      }
    end,
    lazy = true,
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup {
        -- attach_mode = "global",
        -- backends = { "lsp", "treesitter", "markdown", "man" },
        -- disable_max_lines = vim.g.max_file.lines,
        -- disable_max_size = vim.g.max_file.size,
        -- layout = { min_width = 28 },
        -- show_guides = true,
        -- filter_kind = false,
        -- guides = {
        --   mid_item = "├ ",
        --   last_item = "└ ",
        --   nested_top = "│ ",
        --   whitespace = "  ",
        -- },
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        disable_max_lines = vim.g.max_file.lines,
        disable_max_size = vim.g.max_file.size,
        layout = { min_width = 28 },
        show_guides = true,
        filter_kind = false,
        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },
        keymaps = {
          ["[y"] = "actions.prev",
          ["]y"] = "actions.next",
          ["[Y"] = "actions.prev_up",
          ["]Y"] = "actions.next_up",
          ["{"] = false,
          ["}"] = false,
          ["[["] = false,
          ["]]"] = false,
        },
      }

      require("telescope").load_extension "aerial"

      require("core.utils").load_mappings "aerial"
    end,
    lazy = true,
  },

  -- themes
  {
    "briones-gabriel/darcula-solid.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
}

return plugins
