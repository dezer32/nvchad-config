return {
  -- Icons for completion menu
  {
    "onsails/lspkind.nvim",
    lazy = true,
    config = function()
      require("lspkind").init {
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
          Copilot = "",
        },
      }
    end,
  },

  -- Enhanced completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    opts = function()
      local cmp = require "cmp"
      local lspkind = require "lspkind"

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function(entry, vim_item)
              return vim_item
            end,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "nvim_lua", priority = 500 },
          { name = "path", priority = 250 },
        }, {
          { name = "buffer", priority = 50 },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
}
