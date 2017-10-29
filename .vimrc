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

set number
set background=dark
set rnu
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
syntax on
set ruler
set laststatus=2
set list
"set Ctrl-D and Ctrl-U to srcoll 5 lines instead of half a page
set scroll=5
nnoremap J <C-d>
nnoremap K <C-u>
"hi SpecialKey ctermfg=white			hello     
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<
"set listchars=eol:$,eol:¬,tab:>-,trail:~,extends:>,precedes:<
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_browse_split = 4
set tabstop=4
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END
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
match OverLength /\%81v.\+/
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
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
au BufWinLeave * mkview
au BufWinEnter * loadview
"For Ukrainian keyboard layout (can't be wrapped in 80 columns)"
set langmap='йцукенгшщзхїфівапролджєячсмитьбю~ЙЦУКЕHГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"Set vim colors to 256"
set t_Co=256

"=======================================================================
"=======						MAPPINGS						========
"=======================================================================

"---With snippets---"

"Creating an int	main(void) block by typing in insert mode ;imv"
inoremap ,imv <Esc>:read $HOME/.vim/snippets/.intmainvoid.c<CR>2jA
"Creating an int	main(int argc, char **argv)"
inoremap ,imar <Esc>:read $HOME/.vim/snippets/.intmainargcargv.c<CR>2jA

"---Without snippets---"

inoremap ,, <Esc>0/<++><cr>"_c4l
nnoremap ,, <Esc>0/<++><cr>"_c4l
"printf(); with parentheses and appropriate cursor position"
inoremap ,pf printf();<Esc>hi
inoremap ,wr write(1, , <++>);<Esc>F,i
"Adding symbols around the words
vnoremap ,( c()<Esc>hp
vnoremap ,[ c[]<Esc>hp
vnoremap ,< c<><Esc>hp
vnoremap ," c""<Esc>hp
"Adding and deleting comments for a line
vnoremap ,* c/*<cr>*/<Esc>hP
vnoremap ,d* d"_dkP

"ABBREVIATIONS"

iabbrev stdioh #include <stdio.h>
iabbrev unistdh #include <unistd.h>
iabbrev stdlibh #include <stdlib.h>
iabbrev stringh #include <string.h>
