vim.g.maplocalleader = " "
vim.g.mapleader = vim.g.maplocalleader

local map = vim.keymap.set
local opts = require("util").mapping_opts

-- Core
--------------------------------------------------------------------------------------------------
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

map({ "n", "v" }, "<leader>P", '"+p', opts("Paste from system clipboard"))
map({ "n", "v" }, "<leader>Y", '"+y', opts("Yank from system clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', opts("Delete without yank"))
map({ "n", "v" }, "<leader>c", '"_c', opts("Cut without yank"))
map("v", "<leader>p", '"_dP', opts("Paste without yank"))

-- Toggle Terminal
--------------------------------------------------------------------------------------------------
map("n", "<A-i>", function()
  vim.cmd("ToggleTerm")
  vim.o.spell = false
end, opts("Toggle terminal"))
map("t", "<A-i>", "<CMD> ToggleTerm <CR>", opts("Toggle Terminal"))

-- File Tree
--------------------------------------------------------------------------------------------------
map("n", "<leader>e", "<CMD> NvimTreeToggle <CR>", opts("Toggle file explorer split"))

-- Buffer Line
--------------------------------------------------------------------------------------------------
map("n", "<C-q>", "<CMD> BufferClose <CR>", opts("Close buffer"))
map("n", "<S-l>", "<CMD> BufferNext <CR>", opts("Goto next buffer"))
map("n", "<S-h>", "<CMD> BufferPrevious <CR>", opts("Goto previous buffer"))
map("n", "<A-l>", "<CMD> BufferMoveNext <CR>", opts("Move buffer next"))
map("n", "<A-h>", "<CMD> BufferMovePrevious <CR>", opts("Move buffer previous"))

-- Fizzy Finder
--------------------------------------------------------------------------------------------------
map("n", "<leader>fi", "<CMD> Telescope find_files <CR>", opts("Find Files"))
map("n", "<leader>fg", "<CMD> Telescope live_grep <CR>", opts("Project live grep"))
map("n", "<leader>fh", "<CMD> Telescope help_tags <CR>", opts("Find vim help tag"))
map("n", "<leader>fa", "<CMD> Telescope builtin <CR>", opts("All telescope builtin functions"))
map(
  "n",
  "<leader>fl",
  "<CMD> Telescope find_files follow=true no_ignore=true hidden=true  <CR>",
  opts("Find all")
)
map(
  "n",
  "<leader>fs",
  "<CMD> Telescope current_buffer_fuzzy_find <CR>",
  opts("Find in current buf")
)

-- DAP
--------------------------------------------------------------------------------------------------
map("n", "<F5>", function()
  require("dap").continue()
  require("dapui").open()
end, opts("Start/Continue debugging"))
map("n", "<F10>", "<CMD> DapStepOver <CR>", opts("Step over"))
map("n", "<F11>", "<CMD> DapStepInto <CR>", opts("Step into"))
map("n", "<F12>", "<CMD> DapStepOut <CR>", opts("Step out"))
map("n", "<leader>dt", function()
  require("dap").terminate()
  require("dapui").close()
end, opts("Terminate dap session"))

-- Breakpoints
map("n", "<leader>br", "<CMD> DapToggleBreakpoint <CR>", opts("Toggle breakpoint"))
map("n", "<leader>bc", function()
  require("dap").clear_breakpoints()
end, opts("Clear breakpoints"))
map("n", "<leader>de", function()
  require("dapui").eval()
end, opts("Dap evaluation of variable under cursor"))

-- map("n", "<leader>dm", "<CMD> FzfLua dap_commands <CR>", opts("Show dap commands"))
-- map("n", "<leader>dc", "<CMD> FzfLua dap_configurations <CR>", opts("Show dap configurations"))
-- map("n", "<leader>bl", "<CMD> FzfLua dap_breakpoints <CR>", opts("List breakpoints"))
-- map("n", "<leader>dl", "<CMD> FzfLua dap_variables <CR>", opts("Show dap variables"))
-- map("n", "<leader>df", "<CMD> FzfLua dap_frames <CR>", opts("Show dap frames"))
