-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/catgoose/nvim-colorizer.lua

-- Description:
-- A high-performance color highlighter for Neovim

local function config()
	vim.o.termguicolors = true
	require 'colorizer'.setup({
		filetypes = { '*' },
		options = {
			parsers = {
				names = { enable = false },
				hex = { default = false, rgb = true, rrggbb = true, rgba = false },
			},
		}
	})
end

return {
	'catgoose/nvim-colorizer.lua',
	config = config,
}
