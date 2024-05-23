local ui = require("core.ui")

local icons = require("core.icons")

return {
    "folke/noice.nvim",
    name = "noice",
    event = "VeryLazy",
    dependencies = {
        "nui",
    },
    opts = {
        cmdline = {
            format = {
                cmdline = { pattern = "^:", icon = icons.cmdline.cmdline, lang = "vim" },
                search_down = {
                    title = "Search",
                    kind = nil,
                    pattern = "^/",
                    icon = icons.cmdline.search,
                    lang = "regex",
                },
                search_replace = {
                    title = "Find and Replace",
                    pattern = { "^:%%s/", "^:%%s%:", "^:%%s%!", "^:%%s%*" },
                    icon = icons.cmdline.filter,
                    confirm = true,
                    lang = "regex",
                },
                highlighted_search_replace = {
                    title = "Find and Replace",
                    pattern = { "^:'<,'>s/", "^:'<,'>s%:", "^:'<,'>s%!", "^:'<,'>s%*" },
                    icon = icons.cmdline.filter_highlighted,
                    confirm = true,
                    lang = "regex",
                },
                lua = {
                    pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                    icon = icons.cmdline.lua,
                    lang = "lua",
                },
                python = {
                    pattern = { "^:%s*python%s+", "^:%s*python%s*=%s*", "^:%s*=%s*" },
                    icon = icons.cmdline.python,
                    lang = "python",
                },
                help = { pattern = "^:%s*he?l?p?%s+", icon = icons.cmdline.help },
            },
        },
        redirect = {
            view = "mini",
            filter = { event = "msg_show" },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true,
                    luasnip = true,
                    throttle = 50,
                },
            },
            documentation = {
                view = "hover",
                opts = {
                    lang = "markdown",
                    replace = true,
                    render = "plain",
                    format = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
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
                filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" },
                skip = true,
            },
        },
        views = {
            mini = {
                timeout = 3500,
                zindex = 40,
                position = { col = -2 },
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
            bottom_search = false,
            command_palette = true,
            long_message_to_split = false,
            inc_rename = false,
            lsp_doc_border = true,
        },
    },
}
