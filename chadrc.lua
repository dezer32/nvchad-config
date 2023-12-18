---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  statusline = {
    theme = "minimal",
    -- separator_style = "round",
  },

  theme = "decay",
  theme_toggle = { "decay", "one_light" },

  extended_integrations = { "dap", "hop", "bufferline", "codeactionmenu" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
