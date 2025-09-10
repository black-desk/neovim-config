-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

require("black_desk.utils")
local M = {}

M.ensure_python3_provider = function()
	if vim.fn.executable('pynvim-python') == 1 then
		return
	end

	if vim.fn.executable('uv') == 0 then
		utils.run_command(
			"curl -LsSf https://astral.sh/uv/install.sh | sh",
			"Installing uv",
			true)
	end

	utils.run_command(
		"uv tool install pynvim",
		"Installing pynvim",
		true)
end

return M