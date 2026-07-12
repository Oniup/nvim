local ui = require("config.ui")

local kind = {
  Text = "󱌯",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "󰯠",
  Unit = "",
  Value = "",
  Enum = "",
  EnumMember = "",
  Keyword = "",
  Snippet = "",
  Color = "♥",
  File = "󰧮",
  Reference = "",
  Folder = "󰉖",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  Parameter = "󰘦",
  Unknown = "?",
  Number = "",
  Boolean = "󰨚",
  Character = "󱌯",
  String = "",
}

local menu_names = {
  nvim_lsp = "lsp",
  nvim_lua = "lsp",
  luasnip = "snip",
  path = "path",
  crates = "crates",
  cmdline = "command",
  calc = "calc",
  emoji = "emoji",
  buffer = "buffer",
  treesitter = "treesitter",
  tmux = "tmux",
}

local function has_words_before()
  local unpack = table.unpack or nil
  if unpack then
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  return false
end

local function format_popup(entry, item)
  local insert = table.insert
  local concat = table.concat
  local fmt = {
    abbr = item.abbr,
    kind = "",
    menu = "",
  }
  local builder = {}
  local wrap = ui.cmp.menu.wrap

  -- Menu UI options
  if ui.cmp.menu.source then
    insert(builder, (menu_names)[entry.source.name] or "unknown")
  end
  if ui.cmp.menu.kind then
    insert(builder, item.kind)
  end
  fmt.menu = wrap[1] .. concat(builder, " ") .. wrap[2]

  -- Kind UI options
  builder = {}
  wrap = ui.cmp.kind.wrap_name
  if ui.cmp.kind.icon then
    insert(builder, kind[item.kind] or "?")
  end
  if ui.cmp.kind.name then
    insert(builder, wrap[1] .. string.lower(item.kind) .. wrap[2])
  end
  fmt.kind = concat(builder, " ")

  -- Content
  if ui.cmp.fixed_width then
    local max_abbr_width = ui.calculate_fixed_width_size(ui.cmp.fixed_width)
    if #item.abbr > max_abbr_width then
      fmt.abbr = vim.fn.strcharpart(item.abbr, 0, max_abbr_width - 3) .. "..."
    else
      fmt.abbr = item.abbr .. (" "):rep(max_abbr_width - #item.abbr)
    end
  end
  return vim.tbl_deep_extend("force", item, fmt)
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    vim.o.pumheight = 15

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<TAB>"] = function(fallback)
          if not cmp.select_next_item() then
            if vim.bo.buftype ~= "prompt" and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,
        ["<S-TAB>"] = function(fallback)
          if not cmp.select_prev_item() then
            if vim.bo.buftype ~= "prompt" and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      preselect = cmp.PreselectMode.None,
      completion = { completeopt = "menu,menuone,noselect" },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "emoji" },
        -- { name = "buffer" },
        -- { name = "luasnip" }
        -- { name = "calc" },
        -- { name = "treesitter" },
        -- { name = "crates" },
      }),
      window = {
        completion = {
          scrollbar = false,
        },
      },
      formatting = {
        fields = ui.cmp.field_arrangement,
        format = format_popup,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    })
  end,
}
