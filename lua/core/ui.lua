local M = {}

local icons = require("core.icons")

M.border = {
    style = "solid",
    chars = {
        single = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        double = {
            prompt = { "═", "║", " ", "║", "╔", "╗", "║", "║" },
            results = { "═", "║", "═", "║", "╠", "╣", "╝", "╚" },
            preview = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
        },
        rounded = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        shadow = {
            prompt = { " ", "░", " ", " ", " ", " ", "░", " " },
            results = { " ", "░", "░", " ", " ", "░", "░", " " },
            preview = { " ", "░", "░", " ", " ", "░", "░", " " },
        },
        solid = { " ", " ", " ", " ", " ", " ", " ", " " },
        none = {},
    },
}

M.cmp = {
    menu = {
        source = false,
        kind = false,
        wrap = { "", "" },
    },
    kind = {
        icon = true,
        name = false,
        wrap_name = { "(", ")" },
    },
    field_arrangement = { "kind", "menu", "abbr" },
    selected_background_color = "PmenuSel",
    fixed_width = 0.4,
}

M.cmp.window = {
    completion = {
        winhighlight = "Normal:NormalFloat,CursorLine:" .. M.cmp.selected_background_color,
        border = M.border.style,
    },
    documentation = {
        winhighlight = "Normal:NormalFloat",
        border = M.border.style,
    },
}

M.lsp = {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        border = M.border.style,
        source = "always",
        header = "",
        prefix = "",
    },
}

M.dapui = {
    controls = {
        element = "console",
        enabled = true,
        icons = icons.dapui.debugging_controls,
    },
    layouts = {
        {
            size = 0.5,
            position = "left",
            elements = {
                { id = "scopes", size = 0.50 },
                { id = "watches", size = 0.25 },
                { id = "stacks", size = 0.25 },
            },
        },
        {
            size = 0.2,
            position = "bottom",
            elements = {
                { id = "console", size = 1.0 },
            },
        },
    },
}

M.fzf_themes = {
    default = {
        border = M.border.style == "solid" and M.border.chars.solid or M.border.style,
        fullscreen = false,
        width = 0.5,
        height = 0.6,
        preview = {
            border = "noborder",
            wrap = "nowrap",
            hidden = "hidden",
            layout = "flex",
            title = true,
            title_pos = "center",
            vertical = "down:45%",
            horizontal = "right:70%",
            scrollbar = "border",
            scrolloff = vim.opt["scrolloff"],
            delay = 0,
            scrollchars = { icons.seporators.vertical.thick, "" },
            winopts = {
                number = true,
                relativenumber = false,
                cursorline = true,
                cursorcolumn = false,
                wrap = false,
                signcolumn = "no",
                list = false,
                foldenable = false,
            },
        },
    },
    enable_preview = {
        width = 0.8,
        preview = {
            hidden = "nohidden",
        },
    },
}

return M
