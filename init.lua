local u = require("core.utils")

local function load_core_vim_settings()
    -- Load vim options
    u.load_options(require("core.options"))

    -- Load key mappings
    local mappings = require("core.mappings")
    mappings.load_core()
    mappings.load_plugins()
end

local function load_plugins()
    -- Download lazy if doesn't exist
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Load plugins
    require("lazy").setup({
        -- { import = "plugins." },
        { import = "plugins.bars" },
        { import = "plugins.core" },
        { import = "plugins.lsp" },
        { import = "plugins.qol" },
    }, require("core.lazy_options"))
end

local function set_plugins_to_load_on_file_open()
    local plugins = {
        "barbar",
        "gitsigns",
        "lualine",
        "satellite",
        "todo-comments",
        "cmp",
    }

    for _, plug in ipairs(plugins) do
        u.lazy_load_plugin_on_file_open(plug)
    end
end

load_core_vim_settings()
load_plugins()
set_plugins_to_load_on_file_open()
