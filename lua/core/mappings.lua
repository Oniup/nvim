local map = vim.keymap.set
local opts = require("core.utils").mapping_opts

local M = {}

function M.load_core()
    vim.g.maplocalleader = " "
    vim.g.mapleader = vim.g.maplocalleader

    map("i", "jk", "<ESC>", opts("Exit insert mode"))
    map("n", "<leader>nh", "<CMD> noh <CR>", opts("Hide search highlights"))
    map("t", "JK", "<C-\\><C-n>", opts("Exit insert mode"))

    map("n", "<C-h>", "<C-w>h", opts("Window navigation"))
    map("n", "<C-j>", "<C-w>j", opts("Window navigation"))
    map("n", "<C-k>", "<C-w>k", opts("Window navigation"))
    map("n", "<C-l>", "<C-w>l", opts("Window navigation"))

    map("n", "<leader>sj", "<CMD> split <CR>", opts("Split window"))
    map("n", "<leader>sl", "<CMD> vsplit <CR>", opts("Split window"))

    map("n", "<C-Up>", "<CMD> resize +2 <CR>", opts("Resize window"))
    map("n", "<C-Down>", "<CMD> resize -2 <CR>", opts("Resize window"))
    map("n", "<C-Left>", "<CMD> vertical resize -2 <CR>", opts("Resize window"))
    map("n", "<C-Right>", "<CMD> vertical resize +2 <CR>", opts("Resize window"))

    map({ "n", "v" }, "<leader>d", '"_d', opts("Delete without yank"))
    map({ "n", "v" }, "<leader>c", '"_c', opts("Cut without yank"))
    map("v", "<leader>p", '"_dP', opts("Paste without yank"))
end

M.load_plugins = require("plugins.mappings").load_mappings

return M
