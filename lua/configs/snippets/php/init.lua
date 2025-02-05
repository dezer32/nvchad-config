local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

-- "<?php", "", "declare(strict_types=1);", "", "namespace $1;", "", "class {{filename}} {", "", "}"

local filename = function()
  return vim.fn.expand "%:t:r" -- Имя файла без пути и расширения
end

local namespace = require "modules.php_namespace"

ls.add_snippets("all", {
  s("phpclass", {
    t {
      "<?php",
      "",
      "declare(strict_types=1);",
      "",
      "namespace ",
    },
    f(require("modules.php_namespace").generate_namespace, {}),
    t {
      ";",
      "",
      "class ",
    },
    f(filename, {}),
    t { " {", "" },
    i(1, "Your code here..."),
    t { "", "}" },
  }),
})
