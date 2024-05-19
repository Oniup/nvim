local map = vim.keymap.set
local opts = require("core.utils").mapping_opts

local function file_explorer()
    map("n", "<leader>e", "<CMD> NvimTreeToggle <CR>", opts("Toggle file explorer split"))
end

local function fuzzy_finder()
    map("n", "<leader>fi", "<CMD> Telescope find_files <CR>", opts("Find Files"))
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
    map("n", "<leader>fg", "<CMD> Telescope live_grep <CR>", opts("Project live grep"))
    map("n", "<leader>fh", "<CMD> Telescope help_tags <CR>", opts("Find vim help tag"))
    map("n", "<leader>fa", "<CMD> Telescope builtin <CR>", opts("All telescope builtin functions"))
end

local function buffer_bar()
    map("n", "q", "<CMD> BufferClose <CR>", opts("Close buffer"))
    map("n", "<S-l>", "<CMD> BufferNext <CR>", opts("Goto next buffer"))
    map("n", "<S-h>", "<CMD> BufferPrevious <CR>", opts("Goto previous buffer"))
    map("n", "<A-l>", "<CMD> BufferMoveNext <CR>", opts("Move buffer next"))
    map("n", "<A-h>", "<CMD> BufferMovePrevious <CR>", opts("Move buffer previous"))
end

local function toggle_terminal()
    map("n", "<A-i>", function()
        vim.cmd("ToggleTerm")
        vim.o.spell = false
    end, opts("Toggle terminal"))
    map("t", "<A-i>", "<CMD> ToggleTerm <CR>", opts("Toggle Terminal"))
end

local function dap()
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
    map("n", "<leader>bl", "<CMD> Telescope dap list_breakpoints <CR>", opts("List breakpoints"))

    -- Telescope dap menus
    map("n", "<leader>dm", "<CMD> Telescope dap commands <CR>", opts("Show jap commands"))
    map(
        "n",
        "<leader>dc",
        "<CMD> Telescope dap configurations <CR>",
        opts("Show dap configurations")
    )
    map("n", "<leader>jl", "<CMD> Telescope dap variables <CR>", opts("Show dap variables"))
    map("n", "<leader>df", "<CMD> Telescope dap frames <CR>", opts("Show dap frames"))
end

local M = {}

function M.load_mappings()
    file_explorer()
    fuzzy_finder()
    buffer_bar()
    toggle_terminal()
    dap()
end

function M.lsp_load_buf_mappings(client, bufnr)
    local function lsp_opts(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    map("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts("Signature Help"))
    map("n", "gd", "<cmd> Telescope lsp_definitions <cr>", lsp_opts("Goto definitions"))
    map("n", "gi", "<cmd> Telescope lsp_implementations <cr>", lsp_opts("Goto implementations"))
    map("n", "gt", "<cmd> Telescope lsp_type_definitions <cr>", lsp_opts("Goto type definitions"))
    map("n", "gr", "<cmd> Telescope lsp_references <cr>", lsp_opts("List references"))
    map("n", "gl", vim.diagnostic.open_float, lsp_opts("Open diagnostics hover info"))
    map("n", "K", vim.lsp.buf.hover, lsp_opts("Open hover info"))
    map(
        "n",
        "<leader>di",
        "<cmd> Telescope diagnostics <cr>",
        lsp_opts("See all diagnostics in bufnrfer")
    )
    map("n", "<leader>fo", vim.lsp.buf.format, lsp_opts("Format file"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, lsp_opts("Code actions"))
    map("n", "<leader>re", vim.lsp.buf.rename, lsp_opts("Rename"))
    map("n", "<leader>gn", vim.diagnostic.goto_next, lsp_opts("Go to next diagnostic"))
    map("n", "<leader>gp", vim.diagnostic.goto_prev, lsp_opts("Go to prev diagnostic"))

    if client == "clangd" then
        map(
            "n",
            "<leader>o",
            "<CMD> ClangdSwitchSourceHeader <CR>",
            lsp_opts("Switch between source/header")
        )
    end
end

return M
