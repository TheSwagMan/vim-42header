" **************************************************************************** "
"                                                   ,---.                      "
"  customheader.vim                               ,.'-.   \                    "
"                                                ( ( ,'"""""-.                 "
"  Thomas POTIER <thomas.potier@outlook.com>     `,X          `.               "
"                                                /` `           `._            "
"                                               (            ,   ,_\           "
"                                               |          ,---.,'o `.         "
"                                               |         / o   \     )        "
"                                                \ ,.    (      .____,         "
"                                                   \|     ____,'     \        "
"                                               '`'\  \        _,____,'        "
"                                               \  ,--      ,-'     \          "
"                                                 ( C     ,'         \         "
"                                                  `--'  .'           |        "
"                                                    |   |         .O |        "
"                                                   __|            ,-'_        "
"                                                 / `L     `._  _,'  ' `.      "
"                                                /    `--.._  `',.   _\  `     "
"  C: 2017/08/04 23:53 by Thomas POTIER          `-.       /\  | `. ( ,\  \    "
"  M: 2017/08/04 23:53 by Thomas POTIER         _/  `-._  /  \ |--'  (     \   "
"                                              '  `-.   `'    \/\`.   `.    )  "
"  CustomHeader ! v1.0                               \  -hrr-    \ `.  |    |  "
" **************************************************************************** "

" **************************************************************************** "
"                                                   ,---.                      "
"  customheader.vim                               ,.'-.   \                    "
"                                                ( ( ,'"""""-.                 "
"  Thomas POTIER <thomas.potier@outlook.com>     `,X          `.               "
"                                                /` `           `._            "
"                                               (            ,   ,_\           "
"                                               |          ,---.,'o `.         "
"                                               |         / o   \     )        "
"                                                \ ,.    (      .____,         "
"                                                   \|     ____,'     \        "
"                                               '`'\  \        _,____,'        "
"                                               \  ,--      ,-'     \          "
"                                                 ( C     ,'         \         "
"                                                  `--'  .'           |        "
"                                                    |   |         .O |        "
"                                                   __|            ,-'_        "
"                                                 / `L     `._  _,'  ' `.      "
"                                                /    `--.._  `',.   _\  `     "
"  C: 2017/08/04 23:52 by Thomas POTIER          `-.       /\  | `. ( ,\  \    "
"  M: 2017/08/04 23:52 by Thomas POTIER         _/  `-._  /  \ |--'  (     \   "
"                                              '  `-.   `'    \/\`.   `.    )  "
"  CustomHeader ! v1.0                               \  -hrr-    \ `.  |    |  "
" **************************************************************************** "

let s:asciiart	= [
			\"     ,---.                    ",
			\"   ,.'-.   \\                  ",
			\"  ( ( ,'\"\"\"\"\"-.               ",
			\"  `,X          `.             ",
			\"  /` `           `._          ",
			\" (            ,   ,_\\         ",
			\" |          ,---.,'o `.       ",
			\" |         / o   \\     )      ",
			\"  \\ ,.    (      .____,       ",
			\"   \\| \    \____,'     \\      ",
			\" '`'\\  \\        _,____,'      ",
			\" \\  ,--      ,-'     \\        ",
			\"   ( C     ,'         \\       ",
			\"    `--'  .'           |      ",
			\"      |   |         .O |      ",
			\"    __|    \        ,-'_      ",
			\"   / `L     `._  _,'  ' `.    ",
			\"  /    `--.._  `',.   _\\  `   ",
			\"  `-.       /\\  | `. ( ,\\  \\  ",
			\" _/  `-._  /  \\ |--'  (     \\ ",
			\"'  `-.   `'    \\/\\`.   `.    )",
			\"      \\  -hrr-    \\ `.  |    |"
			\]
let s:plugname	= 'CustomHeader ! v1.0'

let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 3
let s:height	= len(s:asciiart) + 2
let s:fileline	= 3
let s:nameline	= 5
let s:crtline	= s:height - 4
let s:modline	= s:height - 3
let s:credline	= s:height - 1

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
			\['/*', '*/', '*'],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '//', '*'],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/'],
			\'Makefile':
			\['#', '#', '#']
			\}

function! s:filetype()
	let l:f = s:filename()
	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor
endfunction

function! s:checkfiletype()
	let l:f = s:filename()
	for type in keys(s:types)
		if l:f =~ type
			return 1
		endif
	endfor
	return 0
endfunction

function! s:ascii(n)
	return s:asciiart[a:n - 2]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == s:height
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
	elseif a:n == s:fileline
		return s:textline(s:filename(), s:ascii(a:n))
	elseif a:n == s:nameline
		return s:textline(s:name() . " <" . s:mail() . ">", s:ascii(a:n))
	elseif a:n == s:crtline
		return s:textline("C: " . s:date() . " by " . s:name(), s:ascii(a:n))
	elseif a:n == s:modline
		return s:textline("M: " . s:date() . " by " . s:name(), s:ascii(a:n))
	elseif a:n == s:credline
		return s:textline(s:plugname, s:ascii(a:n))
	else
		return s:textline('', s:ascii(a:n))
	endif
endfunction

function! s:name()
	let l:name = $FULLNAME
	if strlen(l:name) == 0
		let l:name = "Nobody"
	endif
	return l:name
endfunction

function! s:mail()
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "no@add.ress"
	endif
	return l:mail
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M")
endfunction

function! s:insert()
	let l:line = s:height
	call append(0, "")
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
	call s:filetype()
	if getline(s:height - 2) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "M: "
		if &mod
			call setline(s:modline, s:line(s:modline))
		endif
		call setline(s:fileline, s:line(s:fileline))
		return 0
	endif
	if s:checkfiletype()
		return 1
	endif
	return 0
endfunction

function! s:customheader()
	if s:update()
		call s:insert()
	endif
endfunction

command! CustomHeader call s:customheader ()
nmap <f1> <esc>:CustomHeader<CR>
autocmd BufWritePre	*	call s:customheader ()
