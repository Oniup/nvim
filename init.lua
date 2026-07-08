require("config.options")
require("config.keymaps").core()

if vim.g.neovide then
  -- Window
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true

  -- Cursor
  vim.g.neovide_cursor_animation_length = 0.0
  vim.g.neovide_scroll_animation_length = 0.1
  vim.o.guifont = "Hasklug Nerd Font:h15"
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
}, {
  change_detection = { enabled = false },
})
