-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

local M = {}

---
---Run a shell command.
---
---@param command string
---@param trace_message string
---@param exit boolean
---@return string output
---@return boolean ok
M.run_command = function(command, trace_message, exit)
        vim.api.nvim_echo({
                { "Running command to " .. trace_message .. "..." },
        }, true, {})

        local out = vim.fn.system(command)
        if vim.v.shell_error == 0 then
                return out, true
        end

        vim.api.nvim_echo({
                { "Failed to " .. trace_message .. ":\n", "ErrorMsg" },
                { out .. "\n",                            "WarningMsg" },
        }, true, {})
        if not exit then
                return out, false
        end

        vim.api.nvim_echo({
                { "Press any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
end


M.set_local_tabsize = function(size)
	return function()
		vim.opt_local.tabstop = size
		vim.opt_local.shiftwidth = size
		vim.opt_local.softtabstop = size
	end
end

return M
