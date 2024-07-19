local M = {}

function M.mapping_opts(desc)
  return { silent = true, noremap = true, desc = desc }
end

M.mason_install_path = vim.fn.stdpath("data") .. "/mason/packages"

--- calls pcall for require to checks if the module exists
--- @param module_name string
--- @return table|nil module If exists with no errors, return the result, otherwise will print error if found with errors, otherwise nil
function M.prequire(module_name)
  local ok, result = pcall(require, module_name)
  if not ok and result then
    if not string.find(result, "module '" .. module_name .. "' not found:", 1, true) then
      vim.notify("Failed to prequire:\n" .. result, vim.log.levels.ERROR)
    end
  else
    return result
  end
  return nil
end

function M.dap_config_template(adapter, language, overrides)
  local result = {
    name = "Launch => " .. adapter .. " " .. vim.inspect(language),
    type = adapter,
    request = "launch",
    program = function()
      local exec = vim.fn.getcwd() .. "/"
      exec = exec .. vim.fn.input("Path to exec: " .. exec)
      if exec and vim.fn.has("win32") == 1 then
        exec = string.gsub(exec, "/", "\\") .. ".exe"
      end
      return exec
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
  }
  result = M.map_tbl(result, overrides)
end

return M
