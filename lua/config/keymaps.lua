local M = {}

vim.g.maplocalleader = " "
vim.g.mapleader = vim.g.maplocalleader

local map = vim.keymap.set
local opts = function(description)
  return { silent = true, noremap = true, desc = description }
end

M.core = function()
  -- Core
  --------------------------------------------------------------------------------------------------
  map({ "n", "v" }, "j", "gj")
  map({ "n", "v" }, "k", "gk")
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

  -- File Tree And Projects
  --------------------------------------------------------------------------------------------------
  map("n", "<leader>e", "<CMD> NvimTreeToggle <CR>", opts("Toggle file explorer split"))

  map("n", "C-S-P", "<CMD> NeovimLoadProject <CR>")

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

  -- Git signs
  --------------------------------------------------------------------------------------------------
  map("n", "<leader>hp", "<CMD> Gitsigns preview_hunk <CR>", opts("Preview original git changes"))
  map("n", "<leader>hr", "<CMD> Gitsigns reset_hunk <CR>", opts("Reset to original git changes"))
end

M.dap = function()
  local dap = require("dap")
  local dapui = require("dapui")

  map("n", "<F5>", dap.continue, opts("Debug: Start/Continue"))
  map("n", "<F10>", dap.step_over, opts("Debug: Step Over"))
  map("n", "<F11>", dap.step_into, opts("Debug: Step Into"))
  map("n", "<F12>", dap.step_out, opts("Debug: Step Out"))
  map("n", "<leader>br", dap.toggle_breakpoint, opts("Debug: Toggle Breakpoint"))
  map("n", "<leader>bc", dap.clear_breakpoints, opts("Clear breakpoints"))

  map("n", "<leader>de", dapui.eval, opts("Dap evaluation of variable under cursor"))
  map("n", "<leader>dt", function()
    dap.terminate()
    dapui.close()
  end, opts("Terminate dap session"))
end

M.lsp = function(client, bufnr)
  local function lsp_opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  -- Buffer local mappings
  map("i", "<C-h>", vim.lsp.buf.signature_help, lsp_opts("Signature Help"))
  map("n", "K", vim.lsp.buf.hover, lsp_opts("Open hover info"))
  map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, lsp_opts("Code actions"))
  map("n", "<leader>fo", vim.lsp.buf.format, lsp_opts("Format file"))
  map("n", "<leader>re", vim.lsp.buf.rename, lsp_opts("Rename"))
  map("n", "gd", "<CMD> Telescope lsp_definitions <CR>", lsp_opts("Goto definitions"))
  map("n", "gi", "<CMD> Telescope lsp_implementations <CR>", lsp_opts("Goto implementations"))
  map("n", "gt", "<CMD> Telescope lsp_type_definitions <CR>", lsp_opts("Goto type definitions"))
  map("n", "<leader>lr", "<CMD> Telescope lsp_references <CR>", lsp_opts("List references"))
  map("n", "gl", vim.diagnostic.open_float, lsp_opts("Open diagnostics hover info"))
  map("n", "<leader>gn", vim.diagnostic.goto_next, lsp_opts("Go to next diagnostic"))
  map("n", "<leader>gp", vim.diagnostic.goto_prev, lsp_opts("Go to prev diagnostic"))

  -- Format on save
  if client and client:supports_method("textDocument/formatting", { bufnr = bufnr }) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr, -- Scope this to the current buffer only
      group = vim.api.nvim_create_augroup("LspFormat_" .. bufnr, { clear = true }),
      callback = function()
        vim.lsp.buf.format({
          async = false,
          id = client.id,
        })
      end,
    })
  end

  -- Client-specific mappings
  if client and client.name == "clangd" then
    map("n", "<leader>o", function()
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
    end, lsp_opts("Switch between source/header"))
  end
end

return M
