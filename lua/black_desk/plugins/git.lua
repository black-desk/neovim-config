-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

local gitsigns = {
	-- https://github.com/lewis6991/gitsigns.nvim
	'lewis6991/gitsigns.nvim', -- sign column diff mark
	requires = {
		-- https://github.com/nvim-lua/plenary.nvim
		'nvim-lua/plenary.nvim',
	},
	config = function()
		require('gitsigns').setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol',
				delay = 300,
				ignore_whitespace = false,
			}
		})

		local set_keymap = function(lhs, rhs, desc)
			local desc_prefix = "[gitsigns] "
			local lhs_prefix = "<space>g"
			vim.keymap.set(
				"n", lhs_prefix .. lhs, rhs,
				{ ["desc"] = desc_prefix .. desc }
			)
		end

		set_keymap("w", "<cmd>Gitsigns toggle_word_diff<cr>", "toggle word diff mode")
		set_keymap("j", "<cmd>Gitsigns next_hunk<cr>", "next hunk")
		set_keymap("k", "<cmd>Gitsigns prev_hunk<cr>", "previous hunk")
		set_keymap("u", "<cmd>Gitsigns undo_stage_hunk<cr>", "undo stage hunk")
		set_keymap("s", "<cmd>Gitsigns stage_hunk<cr>", "stage hunk")
		set_keymap("r", "<cmd>Gitsigns reset_hunk<cr>", "reset hunk")
	end
}

return {
	-- https://github.com/tpope/vim-fugitive
	'tpope/vim-fugitive',
	dependencies = {
		-- GBrowser handlers
		{
			-- https://github.com/tpope/vim-rhubarb
			'tpope/vim-rhubarb', -- github
			-- https://github.com/borissov/fugitive-gitea
			'borissov/fugitive-gitea',
			-- https://github.com/shumphrey/fugitive-gitlab.vim
			'shumphrey/fugitive-gitlab.vim',
			-- https://github.com/black-desk/fugitive-gitee.vim
			'black-desk/fugitive-gitee.vim',
		},
		gitsigns,
	},
	config = function()
		vim.g.fugitive_gitea_domains = {
			'https://gitea.black-desk.cn',
			'https://gitea.io',
		}
		vim.g.fugitive_gitlab_domains = {
			'https://salsa.debian.org',
			'https://whgitlab.uniontech.com',
		}
	end,
}
