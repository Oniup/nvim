local M = {}

local icons = require("icons")

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
        icons = icons.dap.debugging_controls,
    },
    layouts = {
        {
            size = 0.5,
            position = "left",
            elements = {
                { id = "scopes",  size = 0.50 },
                { id = "watches", size = 0.25 },
                { id = "stacks",  size = 0.25 },
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

M.telescope_themes = {
    large_with_preview = {
        previewer = true,
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "top",
            anchor = "N",
            width = 0.80,
            height = 0.50,
        },
    },
    smaller_with_no_preview = {
        previewer = false,
        layout_strategy = "center",
        border = M.border.style ~= "none",
        borderchars = M.border.chars[M.border.style],
        layout_config = {
            prompt_position = "top",
            anchor = "N",
            width = 0.40,
            height = 0.50,
        },
    },
}

return M
