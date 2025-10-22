local get_fzf_ignore = function()
  -- local f = assert(io.open(vim.fn.getcwd() .. "/.telescope_ignore", "rb"))
  local f = io.open(vim.fn.getcwd() .. "/.nvimignore", "rb")

  local arr = {}
  if f then
    for line in f:lines() do
      table.insert(arr, line)
    end
    f:close()
  end

  return arr
end

local get_fzf_ignore_file = function()
  local ignore_file = vim.fn.getcwd() .. "/.nvimignore"
  if not vim.loop.fs_stat(ignore_file) then
    return
  end

  return ignore_file
end

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Global settings
    winopts = {
      height = 0.85,
      width = 0.90,
      row = 0.35,
      col = 0.50,
      border = "rounded",
      preview = {
        layout = "flex",
        flip_columns = 120,
        horizontal = "right:50%",
        vertical = "down:45%",
        scrollbar = "float",
        scrollchars = { "█", "" },
      },
    },
    fzf_opts = {
      ["--layout"] = "reverse",
      ["--info"] = "inline",
      ["--height"] = "100%",
      ["--pointer"] = "▶",
      ["--marker"] = "✓",
    },
    keymap = {
      builtin = {
        ["<C-/>"] = "toggle-help",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    -- File settings
    files = {
      formatter = "path.filename_first",
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
    -- LSP settings
    lsp = {
      formatter = "path.filename_first",
      cwd_only = false,
      file_icons = true,
      color_icons = true,
      git_icons = false,
      symbols = {
        symbol_icons = {
          File = "󰈙",
          Module = "",
          Namespace = "󰌗",
          Package = "",
          Class = "󰌗",
          Method = "󰆧",
          Property = "",
          Field = "",
          Constructor = "",
          Enum = "",
          Interface = "",
          Function = "󰊕",
          Variable = "󰀫",
          Constant = "󰏿",
          String = "",
          Number = "󰎠",
          Boolean = "◩",
          Array = "󰅪",
          Object = "󰅩",
          Key = "󰌋",
          Null = "󰟢",
          EnumMember = "",
          Struct = "󰌗",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
        symbol_fmt = function(s)
          return "[" .. s .. "]"
        end,
      },
      finder = {
        formatter = "path.filename_first",
        jump_to_single_result = true,
        file_icons = true,
        color_icons = true,
      },
      code_actions = {
        previewer = "codeaction_native",
        preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit'",
      },
    },
    -- Diagnostics settings
    diagnostics = {
      file_icons = true,
      color_icons = true,
      git_icons = false,
      diag_icons = true,
      icon_padding = " ",
      multiline = true,
      signs = {
        ["Error"] = { text = "", texthl = "DiagnosticError" },
        ["Warn"] = { text = "", texthl = "DiagnosticWarn" },
        ["Info"] = { text = "", texthl = "DiagnosticInfo" },
        ["Hint"] = { text = "", texthl = "DiagnosticHint" },
      },
    },
    -- Preview settings
    preview = {
      border = "border",
      wrap = "nowrap",
      hidden = "nohidden",
      vertical = "down:45%",
      horizontal = "right:50%",
      layout = "flex",
      flip_columns = 120,
      title = true,
      title_align = "center",
      scrollbar = "float",
      scrolloff = "-2",
      scrollchars = { "█", "" },
      delay = 100,
      winopts = {
        number = true,
        relativenumber = false,
        cursorline = true,
        cursorlineopt = "both",
        cursorcolumn = false,
        signcolumn = "no",
        list = false,
        foldenable = false,
        foldmethod = "manual",
      },
    },
    -- Grep settings
    grep = {
      formatter = "path.filename_first",
      git_icons = true,
      file_icons = true,
      color_icons = true,
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
}
