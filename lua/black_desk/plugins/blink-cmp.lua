-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

return {
	'saghen/blink.cmp',
	version = '1.*',
	dependencies = {
		'SirVer/ultisnips',
		'Kaiser-Yang/blink-cmp-dictionary',
	},
	opts = {
		enabled = function()
			if vim.bo.filetype == 'TelescopePrompt' then
				return false
			end
			local ok, rsime = pcall(require, 'rsime')
			return not ok or not rsime.is_active()
		end,
		keymap = {
			preset = 'none',
			['<C-Space>'] = { 'show', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-e>'] = { 'cancel', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
		},
		completion = {
			list = { selection = { preselect = false, auto_insert = false } },
			documentation = { auto_show = true },
		},
		snippets = {
			expand = function(body) vim.fn['UltiSnips#Anon'](body) end,
			active = function(filter)
				if filter and filter.direction == -1 then
					return vim.fn['UltiSnips#CanJumpBackwards']() == 1
				end
				return vim.fn['UltiSnips#CanJumpForwards']() == 1
			end,
			jump = function(direction)
				vim.fn[direction == -1 and 'UltiSnips#JumpBackwards' or 'UltiSnips#JumpForwards']()
			end,
		},
		sources = {
			default = { 'lsp', 'path', 'dictionary' },
			providers = {
				dictionary = {
					name = 'Dictionary',
					module = 'blink-cmp-dictionary',
					min_keyword_length = 2,
					opts = { dictionary_files = { '/usr/share/dict/words' } },
				},
			},
		},
		fuzzy = {
			sorts = function()
				if vim.fn.getcmdtype() ~= '' then return { 'score', 'sort_text' } end
				local priority = { lsp = 1, path = 2, dictionary = 3 }
				return {
					function(a, b)
						local a_priority = priority[a.source_id] or 4
						local b_priority = priority[b.source_id] or 4
						if a_priority ~= b_priority then return a_priority < b_priority end
					end,
					'score',
					'sort_text',
				}
			end,
		},
		cmdline = {
			keymap = {
				preset = 'inherit',
				['<CR>'] = { 'accept_and_enter', 'fallback' },
			},
			sources = function()
				local cmdtype = vim.fn.getcmdtype()
				if cmdtype == '/' or cmdtype == '?' then return { 'buffer' } end
				if cmdtype == ':' then return { 'cmdline', 'path' } end
				return {}
			end,
			completion = {
				list = { selection = { preselect = false, auto_insert = false } },
				menu = { auto_show = true },
				ghost_text = { enabled = false },
			},
		},
	},
}
