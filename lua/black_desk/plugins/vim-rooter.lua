-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

return {
	'airblade/vim-rooter',
	config = function()
		vim.g.rooter_patterns = { '.git' }
	end
}
