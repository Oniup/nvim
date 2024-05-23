local icons = require("core.icons")

return {
    {
        "numToStr/Comment.nvim",
        keys = {
            {
                "gcc",
                mode = "n",
                desc = "Comment toggle current line",
            },
            {
                "gc",
                mode = { "n", "o" },
                desc = "Comment toggle linewise",
            },
            {
                "gc",
                mode = "x",
                desc = "Comment toggle linewise (visual)",
            },
            {
                "gbc",
                mode = "n",
                desc = "Comment toggle current block",
            },
            {
                "gb",
                mode = { "n", "o" },
                desc = "Comment toggle blockwise",
            },
            {
                "gb",
                mode = "x",
                desc = "Comment toggle blockwise (visual)",
            },
        },
        config = true,
    },
    {
        "folke/todo-comments.nvim",
        name = "todo-comments",
        dependencies = {
            "plenary",
        },
        opts = {
            signs = true,
            keywords = {
                FIX = {
                    icon = icons.diagnostics.other.bug,
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = {
                    icon = icons.diagnostics.other.todo,
                    color = "info",
                },
                WARN = {
                    icon = icons.diagnostics.other.warn,
                    color = "warning",
                    alt = { "WARNING" },
                },
                HACK = {
                    icon = icons.diagnostics.other.hack,
                    color = "warning",
                },
                NOTE = {
                    icon = icons.diagnostics.other.note,
                    color = "hint",
                    alt = { "INFO" },
                },
                PERF = {
                    icon = icons.diagnostics.other.perf,
                    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
                },
                TEST = {
                    icon = icons.diagnostics.other.test,
                    color = "test",
                    alt = { "TESTING", "PASSED", "FAILED" },
                },
            },
        },
        search = {
            -- NOTE: Ripgrep related commands
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]],
        },
    },
}
