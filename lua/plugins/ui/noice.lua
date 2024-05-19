local ui = require("core.ui")
local icons = require("core.icons")

local cmdline_icons = icons.noice.cmdline

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        cmdline = {
            format = {
                cmdline = { pattern = "^:", icon = cmdline_icons.cmdline, lang = "vim" },
                search_down = {
                    title = "Search",
                    kind = nil,
                    pattern = "^/",
                    icon = cmdline_icons.search,
                    lang = "regex",
                },
                search_replace = {
                    title = "Find and Replace",
                    pattern = { "^:%%s/", "^:%%s%:", "^:%%s%!", "^:%%s%*" },
                    icon = cmdline_icons.filter,
                    confirm = true,
                    lang = "regex",
                },
                highlighted_search_replace = {
                    title = "Find and Replace",
                    pattern = { "^:'<,'>s/", "^:'<,'>s%:", "^:'<,'>s%!", "^:'<,'>s%*" },
                    icon = cmdline_icons.filter_highlighted,
                    confirm = true,
                    lang = "regex",
                },
                lua = {
                    pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                    icon = cmdline_icons.lua,
                    lang = "lua",
                },
                python = {
                    pattern = { "^:%s*python%s+", "^:%s*python%s*=%s*", "^:%s*=%s*" },
                    icon = cmdline_icons.python,
                    lang = "python",
                },
                help = { pattern = "^:%s*he?l?p?%s+", icon = cmdline_icons.help },
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            -- Word added to spellfile via `zg`
            {
                filter = { event = "msg_show", find = "^Word .*%.add$" },
                view = "mini",
            },
            -- Removing
            {
                filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" },
                skip = true,
            },
            {
                filter = { event = "msg_show", find = "^search hit BOTTOM, continuing at TOP" },
                skip = true,
            },
            {
                filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" },
                skip = true,
            },
            {
                filter = {
                    event = "notify",
                    find = "warning: multiple different client offset_encodings detected for buffer, this is not supported yet",
                },
                skip = true,
            },
        },
        views = {
            mini = {
                timeout = 3500,
                zindex = 10, -- lower, so it does not cover nvim-notify
                position = { col = -3 }, -- to the left to avoid collision with scrollbar
            },
            hover = {
                border = { style = ui.border.style },
                size = { max_width = 80 },
                win_options = { scrolloff = 4, wrap = true },
            },
            popup = {
                border = { style = ui.border.style },
                size = { width = 90, height = 25 },
                win_options = { scrolloff = 8, wrap = true, concealcursor = "nv" },
                close = { keys = { "q", "<D-w>", "<D-9>", "<D-0>" } },
            },
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    },
}
