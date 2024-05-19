local u = require("core.utils")

-- Load vim options
u.load_options(require("core.options"))

-- Load key mappings
local mappings = require("core.mappings")
mappings.load_core()
mappings.load_plugins()

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
    { import = "plugins.core" },
    { import = "plugins.lsp" },
    { import = "plugins.ui" },
    { import = "plugins.qol" },
}, require("core.lazy_opts"))
