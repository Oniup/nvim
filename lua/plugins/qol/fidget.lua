local icons = require("core.icons")

return {
    "j-hui/fidget.nvim",
    name = "fidget",
    lazy = false,
    config = function()
        local fidget = require("fidget")
        fidget.setup({
            progress = {
                suppress_on_insert = true,
                display = {
                    render_limit = 16,
                    done_ttl = 4,
                    done_icon = icons.loading.completed,
                    done_style = "Title",
                    progress_icon = { pattern = icons.loading.loading_spinner },
                    progress_style = "WarningMsg",
                    group_style = "QuickFixLine",
                    icon_style = "QuickFixLine",
                    format_message = require("fidget.progress.display").display_format_message,
                    format_annote = function(msg)
                        return msg.title
                    end,
                    format_group_name = function(group)
                        return tostring(group)
                    end,
                },
            },
            notification = {
                poll_rate = 10,
                filter = vim.log.levels.INFO,
                history_size = 256,
                override_vim_notify = true,
                configs = {
                    default = require("fidget.notification").default_config,
                },
                redirect = function(msg, level, opts)
                    if opts and opts.on_open then
                        return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
                    end
                end,
                view = {
                    stack_upwards = true,
                    icon_separator = " ",
                    group_separator = icons.seporators.horizontal.connected,
                    group_separator_hl = "Operator",
                    render_message = function(msg, cnt)
                        return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
                    end,
                },
                window = {
                    normal_hl = "Normal",
                    winblend = 0,
                    border = "none",
                    zindex = 999,
                    x_padding = 3,
                    y_padding = 0,
                    align = "bottom",
                    relative = "editor",
                },
            },
            integration = {
                ["nvim-tree"] = { enable = true },
            },
        })

        -- Override lua print
        _G.print = function(...)
            local msg = table.concat(vim.tbl_map(tostring, { ... }), " ")
            fidget.notify(msg, "info")
        end
    end,
}
