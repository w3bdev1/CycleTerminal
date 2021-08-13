function! s:GetTerminalBufnrs() abort
	let l:TerminalBufnrs = []
	for buf in getbufinfo()
		if getbufvar(buf.bufnr, '&buftype') ==# 'terminal'
			call add(l:TerminalBufnrs, buf.bufnr)
		endif
	endfor
	return l:TerminalBufnrs
endfunction

function! CycleTerminal() abort
	let l:TerminalBufnrs = s:GetTerminalBufnrs()
	if len(l:TerminalBufnrs) ==# 0
		echo "No Terminal Buffer Found!"
		return ""
	endif

	" If current buffer is a terminal
	let l:CurrentBufnrIndexInTerminalBufnrs = index(l:TerminalBufnrs, bufnr('%'))
	if l:CurrentBufnrIndexInTerminalBufnrs !=# -1
		let l:NextTerminalBufnrIndex = l:CurrentBufnrIndexInTerminalBufnrs + 1
		if l:NextTerminalBufnrIndex < len(l:TerminalBufnrs)
			execute 'buffer '..l:TerminalBufnrs[l:NextTerminalBufnrIndex]
			return ""
		else	
			execute 'buffer '..l:TerminalBufnrs[0]	
		endif
	else
		execute 'bo split | b '..l:TerminalBufnrs[0]
	endif
endfunction
