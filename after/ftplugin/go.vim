" SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
"
" SPDX-License-Identifier: MIT

setlocal noexpandtab

if expand('%:t') !~# '_test\.go$'
	finish
endif

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
