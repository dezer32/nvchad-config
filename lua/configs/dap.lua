local dap = require "dap"

-- DAP signs
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

-- PHP Debug Adapter
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath "data" .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9003,
    log = false,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}",
    },
  },
}

-- JavaScript/TypeScript Debug Adapter (Node.js)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch Node.js",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Node.js",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- Python Debug Adapter
dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    connect = function()
      local host = vim.fn.input "Host [127.0.0.1]: "
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input "Port [5678]: ") or 5678
      return { host = host, port = port }
    end,
  },
}

-- Go Debug Adapter (if you want to add Go support)
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
