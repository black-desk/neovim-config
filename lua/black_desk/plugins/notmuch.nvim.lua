-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

local config = function()
	local notmuch_dir_path = os.getenv("HOME") .. "/mail"
	local opts = {
		notmuch_db_path = notmuch_dir_path,
		maildir_sync_cmd = "cd " .. notmuch_dir_path .. " && gmi sync",
	}

	require('notmuch').setup(opts)
end

return {
	"yousefakbar/notmuch.nvim",
	config = config,
}
