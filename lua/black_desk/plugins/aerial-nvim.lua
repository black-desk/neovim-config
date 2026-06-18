-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

return {
	-- https://github.com/stevearc/aerial.nvim
	'stevearc/aerial.nvim',
	init = function()
		local set_keymap = function(lhs, rhs, desc)
			local desc_prefix = "[aerial] "
			vim.keymap.set(
				"n", lhs, rhs,
				{ ["desc"] = desc_prefix .. desc }
			)
		end

		set_keymap("t", "<cmd>AerialToggle<cr>", "toggle outline")
	end,
	config = function()
		require("aerial").setup()
	end,
	cmd = {
		'AerialToggle',
	}
}
