"Vimplug"
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'
Plug 'altercation/vim-colors-solarized'
Plug 'https://github.com/powerline/powerline'
Plug 'stephenmckinney/vim-solarized-powerline'
Plug 'vimwiki/vimwiki'
Plug 'mmai/vim-markdown-wiki'
Plug 'suan/vim-instant-markdown'
Plug 'francoiscabrol/ranger.vim'
call plug#end()

"statusline test begin

"set laststatus=2
"set statusline=
"set statusline+=%F\ 
"set statusline+=%m\ 
"set statusline+=%r\ 
"set statusline+=%h\ 
"set statusline+=%=
"set statusline+=%y\ 
"set statusline+=%l\/
"set statusline+=%L\ 
"set statusline+=\[b:\ %n\]

"statusline test end


let g:Powerline_colorscheme = 'solarized16_dark'
let g:Powerline_symbols = 'fancy'
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
colorscheme solarized
set nocompatible
filetype plugin on
"for vimwiki plugin, to use murkdown instead of wiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
						\ 'syntax': 'markdown', 'ext': '.md'}]
nnoremap <BS> :MdwiReturn<cr>
"Instant markdown plugin
let g:instant_markdown_autostart = 0 "disable autostart
nnoremap <leader>md :InstantMarkdownPreview<cr> "\md to instantly preview
"For ranger plugin
nnoremap <leader>r :RangerWorkingDirectory<cr>

"=======================================================================
"=======						DEFAULTS						========
"=======================================================================

set tags=./tags;

"set hybrid line numbers
set number relativenumber
set background=dark
"toggle between relative and absolute number
function! ToggleRelativeNumber()
	if &relativenumber
		set norelativenumber
	else
		set relativenumber
	endif
endfunction
"use F3 to toggle between rnu and nu
nmap <F3> :call ToggleRelativeNumber()<CR>
"set so=10
"set working directory to allways be the same as the file you are editing
"set autochdir
syntax on
set ruler
set cul
set laststatus=2
set list
"set Ctrl-D and Ctrl-U to srcoll 5 lines instead of half a page
"set scroll=5
"nnoremap <C-d> 5<C-d>
"nnoremap <C-u> 5<C-u>
nnoremap J 5<C-d>
nnoremap K 5<C-u>
"hi SpecialKey ctermfg=white			hello     
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<
"set listchars=eol:$,eol:¬,tab:>-,trail:~,extends:>,precedes:<
"netrw plugin ("nerdtree")
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_browse_split = 4
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		if expl_win_num != -1
			let cur_win_nr = winnr()
			exec expl_win_num . 'wincmd w'
			close
			exec cur_win_nr . 'wincmd w'
			unlet t:expl_buf_num
		else
			unlet t:expl_buf_num
		endif
	else
		exec '1wincmd w'
		Vexplore
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
set tabstop=4
set autoindent
set cindent
set shiftwidth=4
"Remap Escape for jj"
inoremap jj <Esc>
inoremap оо <Esc>
"Auto close brackets"
inoremap {<CR> {<CR>}<C-o>==<C-o>O
set splitbelow
set splitright
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%<82v.\%>81v/
augroup vimrc
	au BufReadPre ?* setlocal foldmethod=indent
	au BufWinEnter ?* if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
"Remap folds opening"
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"Remap for easy buffer switch"
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
"For compilating and executing in vim, :make"
au BufEnter *.c compiler gcc
set makeprg=gcc\ %\ &&\ ./a.out
"For project specific .vimrc files"
set exrc
set secure
"Save folds (actually saves everything you did before exiting vim)"
au BufWinLeave ?* mkview 1
au BufWinEnter ?* loadview 1
"For Ukrainian keyboard layout (can't be wrapped in 80 columns)"
set langmap='йцукенгшщзхїфівапролджєячсмитьбю~ЙЦУКЕHГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"Set vim colors to 256"
set t_Co=256

"=======================================================================
"=======						MAPPINGS						========
"=======================================================================

"---With snippets---"

"Creating an int	main(void) block by typing in insert mode ,imv"
inoremap ,imv int		main(void)<CR>{<CR><CR><CR>}<Esc>ki	return(0);<Esc>kcc

"Creating an int	main(int argc, char **argv)"
inoremap ,imar int		main(int ac, char **av)<CR>{<CR><CR><CR>}<Esc>ki	return(0);<Esc>kcc

"---Without snippets---"

inoremap ,, <Esc>0/<++><cr>"_c4l
nnoremap ,, <Esc>0/<++><cr>"_c4l
inoremap ,pf printf("\n", <++>);<Esc>F\i
inoremap ,wr write(1, , <++>);<Esc>F,i
inoremap ,wh while ()<CR><++><Esc>ki
inoremap ,if if ()<CR><++><Esc>ki
inoremap ,( ()<++><Esc>F)i
inoremap ,$ $()<++><Esc>F)i

"Adding and deleting symbols around the words
vnoremap ,( c()<Esc>hp
vnoremap ,d( dvhp
vnoremap ,[ c[]<Esc>hp
vnoremap ,d[ dvhp
vnoremap ,< c<><Esc>hp
vnoremap ,d< dvhp
vnoremap ," c""<Esc>hp
vnoremap ,d" dvhp
"Adding and deleting comments for a line
vnoremap ,* c/*<cr>*/<Esc>hP
vnoremap ,d* d"_dkP

"ABBREVIATIONS"

iabbrev stdioh #include <stdio.h>
iabbrev unistdh #include <unistd.h>
iabbrev stdlibh #include <stdlib.h>
iabbrev stringh #include <string.h>
iabbrev libfth #include "libft.h"
iabbrev ctypeh #include <ctype.h>
