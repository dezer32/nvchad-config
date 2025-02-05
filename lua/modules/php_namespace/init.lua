-- lua/custom/php_namespace.lua

local M = {}

-- Определение корня проекта
local function get_project_root()
  local root_markers = { ".git", "composer.json" }
  local path = vim.fn.expand "%:p:h"

  while path ~= "/" do
    for _, marker in ipairs(root_markers) do
      if vim.fn.isdirectory(path .. "/" .. marker) == 1 or vim.fn.filereadable(path .. "/" .. marker) == 1 then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  return nil
end

-- Чтение настроек PSR-4 из composer.json
local function read_psr4_namespace(root)
  local composer_file = root .. "/composer.json"
  if vim.fn.filereadable(composer_file) == 0 then
    return nil
  end

  local file = io.open(composer_file, "r")
  if not file then
    return nil
  end

  local content = file:read "*a"
  file:close()

  local ok, json = pcall(vim.fn.json_decode, content)
  if not ok or not json or not json.autoload or not json.autoload["psr-4"] then
    return nil
  end

  return json.autoload["psr-4"]
end

-- Генерация namespace
function M.generate_namespace()
  local file_path = vim.fn.expand "%:p"

  local project_root = get_project_root()

  if not project_root then
    print "Не удалось определить корень проекта."
    return
  end

  local psr4_namespaces = read_psr4_namespace(project_root)
  local relative_path = file_path:sub(#project_root + 2)
  relative_path = relative_path:gsub("%.php$", "") -- убираем расширение

  if psr4_namespaces then
    for namespace, base_dir in pairs(psr4_namespaces) do
      if relative_path:find(base_dir, 1, true) == 1 then
        local sub_namespace = relative_path:sub(#base_dir + 1):gsub("/", "\\")
        namespace = namespace:gsub("\\$", "") -- убираем лишние слэши
        print(
          "Сгенерированный namespace: "
            .. namespace
            .. (sub_namespace ~= "" and ("\\" .. sub_namespace) or "")
        )
        return namespace .. (sub_namespace ~= "" and ("\\" .. sub_namespace) or "")
      end
    end
  end

  -- Если PSR-4 не найден, используем структуру каталогов
  local namespace = relative_path:gsub("/", "\\"):gsub("\\init$", "")
  -- print("Сгенерированный namespace: " .. namespace)

  return namespace
end

-- Регистрация пользовательской команды
vim.api.nvim_create_user_command("GenerateNamespace", M.generate_namespace, {})

return M
