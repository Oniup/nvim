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

--- For each module, calls pcall for require to check if the module exists.
--- @param module_names table
--- @return table|nil extended_module Result of all listed and then tbl_deep_extend in order
function M.prequire_extend(module_names)
    local modules = {}
    for _, module in ipairs(module_names) do
        local tbl = M.prequire(module)
        if type(tbl) == "table" then
            modules = M.map_tbl(modules, tbl)
        else
            vim.notify(
                "Cannot combine module " .. module .. ", it doesn't return a table",
                vim.log.levels.ERROR
            )
        end
    end
    return modules
end

--- Combines two option tables giving right side options priority
--- @param lhs table Default options
--- @param rhs table|nil Override/add options
---@return table opts Combined options
function M.map_tbl(lhs, rhs)
    if rhs then
        if vim.tbl_islist(rhs) then
            for _, v in pairs(rhs) do
                if v ~= nil then
                    lhs = vim.tbl_deep_extend("force", lhs, v)
                end
            end
        else
            lhs = vim.tbl_deep_extend("force", lhs, rhs)
        end
    end
    return lhs
end

function M.load_options(opts)
    for k, v in pairs(opts) do
        vim.opt[k] = v
    end
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

--- Modified variant of https://github.com/NvChad/NvChad/blob/v2.0/lua/core/utils.lua
function M.lazy_load_plugin_on_file_open(plugin)
    vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("LazyLoadOnFileOpen_" .. plugin, {}),
        callback = function()
            local this = vim.fn.expand("%")
            local not_allowed = { "NvimTree_1", "[lazy]", "[mason]", "" }
            for _, ft in ipairs(not_allowed) do
                if this == ft then
                    return
                end
            end
            vim.api.nvim_del_augroup_by_name("LazyLoadOnFileOpen_" .. plugin)
            require("lazy").load({ plugins = plugin })
        end,
    })
end

return M
