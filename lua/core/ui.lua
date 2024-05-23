local M = {}

local icons = require("core.icons")

M.border = {
    style = "solid",
    telescope = {
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
        source = true,
        kind = false,
        wrap = { "", "" },
    },
    kind = {
        icon = true,
        name = true,
        wrap_name = { "(", ")" },
    },
    field_arrangement = { "abbr", "kind", "menu" },
    selected_background_color = "PmenuSel",
    fixed_width = 0.4,
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
        borderchars = M.border.telescope[M.border.style],
        layout_config = {
            prompt_position = "top",
            anchor = "N",
            width = 0.40,
            height = 0.50,
        },
    },
}

return M
