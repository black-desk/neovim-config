-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/tpope/vim-fugitive

-- Description:
-- git setup

local function config()
	vim.g.fugitive_gitea_domains = {
		'https://gitea.black-desk.cn',
		'https://gitea.io',
	}
	vim.g.fugitive_gitlab_domains = {
		'https://salsa.debian.org',
		'https://whgitlab.uniontech.com',
	}
end

return {
	'tpope/vim-fugitive',
	dependencies = {
		-- GBrowser handlers
		{
			'tpope/vim-rhubarb', -- github
			'borissov/fugitive-gitea',
			'shumphrey/fugitive-gitlab.vim',
			'black-desk/fugitive-gitee.vim',
		},
		{
			-- https://github.com/lewis6991/gitsigns.nvim
			'lewis6991/gitsigns.nvim', -- sign column diff mark
			requires = {
				'nvim-lua/plenary.nvim',
			},
		},
	},
	config = config,
}
