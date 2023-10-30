local dap, dapui = require "dap", require "dapui"
require("core.utils").load_mappings "dapui"

local layouts = {
  {
    -- You can change the order of elements in the sidebar
    elements = {
      { id = "scopes", size = 0.35 },
      { id = "watches", size = 0.20 },
      { id = "stacks", size = 0.35 },
      { id = "breakpoints", size = 0.10 },
      -- { id = "repl", size = 0.25 },
    },
    size = 50,
    position = "right", -- Can be "left" or "right"
  },
  {
    elements = {
      "repl",
      -- "watches",
      -- "console",
    },
    size = 10,
    position = "bottom", -- Can be "bottom" or "top"
  },
}

-- local render = {
--   max_type_length = nil, -- Can be integer or nil.
--   max_value_lines = 100, -- Can be integer or nil.
--   indent = 1,
-- }

dapui.setup {
  layouts = layouts,
  -- render = render,
}

-- dap.listeners.after["event_initialized"]["dapui_config"] = function(session, body)
--   print("Session terminated", vim.inspect(session), vim.inspect(body))
--   dapui.open()
-- end
-- dap.listeners.before["event_terminated"]["dapui_config"] = function(session, body)
--   print("Session terminated", vim.inspect(session), vim.inspect(body))
--   dapui.close()
-- end
-- dap.listeners.before["event_exited"]["dapui_config"] = function(session, body)
--   print("Session terminated", vim.inspect(session), vim.inspect(body))
--   dapui.close()
-- end
