local ui = require("core.ui")
local icons = require("core.icons")

return {
    defaults = {
        lazy = true,
        version = "*",
    },
    install = {
        missing = true,
    },
    checker = {
        enabled = false, -- Makes a massive difference on startup time
        notify = false,
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
    diff = {
        cmd = "git",
    },
    ui = {
        border = ui.border.type,
        size = { width = 0.6, height = 0.6 },
        icons = icons.lazy,
        pills = true,
    },
    profiling = {
        loader = true,
        require = true,
    },
    performance = {
        cache = {
            enabled = false,
        },
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "matchparen",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
}
