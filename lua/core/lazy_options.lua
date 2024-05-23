return {
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
    },
    checker = {
        enabled = false, -- Makes a massive difference on startup time
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
    diff = {
        cmd = "git",
    },
    ui = {
        border = require("core.ui").border.style,
        size = { width = 0.6, height = 0.6 },
        icons = require("core.icons").lazy,
        backdrop = 100,
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
