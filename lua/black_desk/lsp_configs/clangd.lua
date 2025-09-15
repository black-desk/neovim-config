-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--enable-config",
		"--offset-encoding=utf-16",
		"-j=8",
	},
	root_dir = require("lspconfig.util").root_pattern(
		"build/compile_commands.json",
		"compile_commands.json",
		".git"),
}
