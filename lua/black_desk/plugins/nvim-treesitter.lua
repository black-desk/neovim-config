-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/nvim-treesitter/nvim-treesitter

local function config()
	local treesitter = require('nvim-treesitter')
	treesitter.setup {
		install_dir = vim.fn.stdpath('data') .. '/site',
	}

	treesitter.install({ 'c', 'cpp', 'markdown', 'markdown_inline' })

	vim.api.nvim_create_autocmd('FileType', {
		group = vim.api.nvim_create_augroup('black_desk_treesitter', { clear = true }),
		callback = function(event)
			local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
			if not lang or vim.tbl_contains({ 'c', 'cpp', 'rust' }, lang) then
				return
			end
			-- Parsers are installed asynchronously and may not be available yet.
			if pcall(vim.treesitter.start, event.buf, lang) then
				vim.bo[event.buf].syntax = ''
			end
		end,
	})
end

return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	lazy = false,
	build = ':TSUpdate',
	config = config,
}
