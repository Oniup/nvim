local map = vim.keymap.set
local opts = require("core.utils").mapping_opts

local function nvim_tree()
    map("n", "<leader>e", "<CMD> NvimTreeToggle <CR>", opts("Toggle file explorer split"))
end

local function fzf()
    -- Files
    map("n", "<leader>fi", "<CMD> FzfLua files <CR>", opts("Find files"))
    map("n", "<leader>fg", "<CMD> FzfLua live_grep_glob <CR>", opts("Ripgrep"))
    map("n", "<leader>fq", "<CMD> FzfLua quickfix <CR>", opts("List quickfix"))
    map(
        "n",
        "<leader>fl",
        "<CMD> FzfLua files follow=true no_ignore=true hidden=true <CR>",
        opts("Find all files")
    )

    -- Help
    map("n", "<leader>fh", "<CMD> FzfLua help_tags <CR>", opts("Help tags"))
    map("n", "<leader>fa", "<CMD> FzfLua builtin <CR>", opts("All Fzf builtin functions"))

    -- Git
    map("n", "<leader>gs", "<CMD> FzfLua git_status <CR>", opts("Git status"))
    map("n", "<leader>gc", "<CMD> FzfLua git_commits <CR>", opts("Git commit"))
    map("n", "<leader>gb", "<CMD> FzfLua git_branches <CR>", opts("Git branches"))

    -- Misc
    map({ "v", "i" }, "<C-x><C-f>", function()
        require("fzf-lua").complete_file({
            cmd = "rg --files",
            winopts = {
                preview = { hidden = "nohidden" },
            },
        })
    end, opts("Fuzzy complete file path"))
end

local function buffer_bar()
    map("n", "<C-q>", "<CMD> BufferClose <CR>", opts("Close buffer"))
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

    map("n", "<leader>dm", "<CMD> FzfLua dap_commands <CR>", opts("Show dap commands"))
    map("n", "<leader>dc", "<CMD> FzfLua dap_configurations <CR>", opts("Show dap configurations"))
    map("n", "<leader>bl", "<CMD> FzfLua dap_breakpoints <CR>", opts("List breakpoints"))
    map("n", "<leader>dl", "<CMD> FzfLua dap_variables <CR>", opts("Show dap variables"))
    map("n", "<leader>df", "<CMD> FzfLua dap_frames <CR>", opts("Show dap frames"))
end

local M = {}

function M.load_mappings()
    nvim_tree()
    fzf()
    buffer_bar()
    toggle_terminal()
    dap()
end

function M.lsp_load_buf_mappings(client, bufnr)
    local function lsp_opts(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    map("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts("Signature Help"))
    map("n", "K", vim.lsp.buf.hover, lsp_opts("Open hover info"))
    -- map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, lsp_opts("Code actions"))

    map("n", "<leader>fo", vim.lsp.buf.format, lsp_opts("Format file"))
    map("n", "<leader>re", vim.lsp.buf.rename, lsp_opts("Rename"))

    map("n", "gd", "<CMD> FzfLua lsp_definitions <CR>", lsp_opts("Goto definitions"))
    map("n", "gi", "<CMD> FzfLua lsp_implementations <CR>", lsp_opts("Goto implementations"))
    map("n", "gt", "<CMD> FzfLua lsp_typedefs <CR>", lsp_opts("Goto type definitions"))
    map("n", "gr", "<CMD> FzfLua lsp_references <CR>", lsp_opts("List references"))
    map({ "n", "v" }, "<leader>a", "<cmd> FzfLua lsp_code_actions <CR>", lsp_opts("Code actions"))

    map("n", "gl", vim.diagnostic.open_float, lsp_opts("Open diagnostics hover info"))
    map("n", "<leader>gn", vim.diagnostic.goto_next, lsp_opts("Go to next diagnostic"))
    map("n", "<leader>gp", vim.diagnostic.goto_prev, lsp_opts("Go to prev diagnostic"))
    map(
        "n",
        "<leader>di",
        "<cmd> FzfLua lsp_workspace_diagnostics <CR>",
        lsp_opts("Workspace diagnostics")
    )

    if client.name == "clangd" then
        map(
            "n",
            "<leader>o",
            "<CMD> ClangdSwitchSourceHeader <CR>",
            lsp_opts("Switch between source/header")
        )
    end
end

return M
