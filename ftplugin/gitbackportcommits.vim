" SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
"
" SPDX-License-Identifier: MIT

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

if !exists(':Git')
	finish
endif

function! s:GitShowUnderCursor()
	let word = expand('<cword>')
	if word != ''
		execute 'Git show ' . word
	endif
endfunction

nnoremap <buffer> <CR> :call <SID>GitShowUnderCursor()<CR>
