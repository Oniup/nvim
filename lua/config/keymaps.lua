local M = {}

vim.g.maplocalleader = " "
vim.g.mapleader = vim.g.maplocalleader

local map = vim.keymap.set
local opts = function(description)
  return { silent = true, noremap = true, desc = description }
end

M.dap_init = function()
  map("n", "<F5>", "<CMD> DapContinue <CR>", opts("Debug: Start/Continue"))
  map("n", "<leader>br", "<CMD> DapToggleBreakpoint <CR>", opts("Debug: Toggle Breakpoint"))
  map("n", "<leader>bc", "<CMD> DapClearBreakpoints <CR>", opts("Clear breakpoints"))
end

M.dap = function()
  local dap = require("dap")
  local dapui = require("dapui")

  map("n", "<F10>", dap.step_over, opts("Debug: Step Over"))
  map("n", "<F11>", dap.step_into, opts("Debug: Step Into"))
  map("n", "<F12>", dap.step_out, opts("Debug: Step Out"))

  map("n", "<leader>be", dapui.eval, opts("Dap evaluation of variable under cursor"))
  map("n", "<leader>bt", function()
    dap.disconnect({ terminateDebuggee = true })

    -- Wait a little for the process to actually detach before closing the UI to prevent race conditions
    vim.defer_fn(function()
      dapui.close()
    end, 100)
  end, opts("Terminate dap session"))
end

M.lsp_buffer_attach = function(client, bufnr)
  local function lsp_opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  map("n", "K", vim.lsp.buf.hover, lsp_opts("LSP: Open hover info"))
  map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, lsp_opts("LSP: Code actions"))
  map("n", "<leader>fo", vim.lsp.buf.format, lsp_opts("LSP: Format file"))
  map("n", "<leader>re", vim.lsp.buf.rename, lsp_opts("LSP: Rename"))
  map("n", "gd", "<CMD> Telescope lsp_definitions <CR>", lsp_opts("LSP: Goto definitions"))
  map("n", "gi", "<CMD> Telescope lsp_implementations <CR>", lsp_opts("LSP: Goto implementations"))
  map("n", "gt", "<CMD> Telescope lsp_type_definitions <CR>", lsp_opts("LSP: Goto type definition"))
  map("n", "<leader>lr", "<CMD> Telescope lsp_references <CR>", lsp_opts("LSP: List references"))
  map("n", "gl", vim.diagnostic.open_float, lsp_opts("LSP: Open diagnostics hover info"))
  map("n", "<leader>gn", vim.diagnostic.goto_next, lsp_opts("LSP: Go to next diagnostic"))
  map("n", "<leader>gp", vim.diagnostic.goto_prev, lsp_opts("LSP: Go to prev diagnostic"))

  -- Signature help library
  map("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts("Signature Help"))
  -- vim.keymap.set(
  --   { "n", "i" },
  --   "<C-h>",
  --   require("lsp_signature").toggle_floating_win,
  --   opts("LSP: Toggle Signature")
  -- )

  -- Client-specific mappings
  if client and client.name == "clangd" then
    map("n", "<A-o>", function()
      local params = { uri = vim.uri_from_bufnr(bufnr) }
      -- Send the custom request to clangd
      client:request("textDocument/switchSourceHeader", params, function(err, result)
        if err then
          print("Error switching files: " .. tostring(err.message))
          return
        end
        if not result then
          print("Corresponding file not found")
          return
        end
        -- Open the resulting file
        vim.cmd.edit(vim.uri_to_fname(result))
      end, bufnr)
    end, lsp_opts("LSP: Switch between source/header"))
  end
end

M.core = function()
  -- Core
  --------------------------------------------------------------------------------------------------
  map({ "n", "v" }, "j", "gj")
  map({ "n", "v" }, "k", "gk")
  map("i", "jk", "<ESC>", opts("Exit insert mode"))
  map("n", "<leader>nh", "<CMD> noh <CR>", opts("Hide search highlights"))
  map("t", "JK", "<C-\\><C-n>", opts("Exit insert mode"))

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

  -- File Tree And Projects
  --------------------------------------------------------------------------------------------------
  map("n", "<leader>e", "<CMD> NvimTreeToggle <CR>", opts("Toggle file explorer split"))
  map("n", "<C-S-P>", "<CMD> NeovimLoadProject <CR>", opts("Load project"))

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
  map("n", "<C-S-M>", "<CMD> Telescope diagnostics <CR>", opts("List project wide diagnostics"))
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

  -- Git signs
  --------------------------------------------------------------------------------------------------
  map("n", "<leader>hp", "<CMD> Gitsigns preview_hunk <CR>", opts("Preview original git changes"))
  map("n", "<leader>hr", "<CMD> Gitsigns reset_hunk <CR>", opts("Reset to original git changes"))

  -- Other
  --------------------------------------------------------------------------------------------------
  M.dap_init()
  map("n", "<C-S-P>", "<CMD> ProjectList <CR>", opts("Open project/session from list"))

  map({ "v" }, "<C-S-C>", "<CMD> %s/;/{}\\r/g <CR>", opts("Replace ; with {}\\r, useful in C++"))
end

return M
