local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

ls.add_snippets("all", {
  s("filename", {
    -- t "Current file: ",
    f(function()
      return vim.fn.expand "%:t:r" -- Возвращает имя текущего файла
    end, {}),
  }),
})

require "configs.snippets.php"
