if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'shawncplus/phpcomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'StanAngeloff/php.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'jwalton512/vim-blade'
Plug 'leafgarland/typescript-vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'SirVer/ultisnips'
Plug 'mkitt/tabline.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug '/Users/dpolosuk/.brew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
call plug#end()

"=====NERDtree=====
map <C-E> :NERDTreeToggle<CR>
"close vim if only NERDtree window is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"enable line numbers
let NERDTreeShowLineNumbers=1
"make shure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"=====PHP autocompletion=====
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
"longest makes Vim only autocomplete up to the 'longest' string that all the completions have in common and 'menuone' makes the menu spawn even if there is only one result
set completeopt=longest,menuone


"=====Syntastic=====
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"=====vim-closetag=====
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.php'

"=====cpp-syntax=====
let g:cpp_class_scope_highlight = 1

"=====ultisnips=====
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"=====markdown-preview=====
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<leader>m'

"=====fzf-search=====
nnoremap H :Files 
nnoremap L :Buffers<CR>

function! s:find_git_root()
	return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap M :ProjectFiles<CR>

"=====ale======
let g:ale_linters = {
	\'javascript': ['eslint'],
	\'php': 'all',
\ }
let g:ale_php_phpstan_configuration = '/home/dornat/Programming/Matcha/phpstan.neon'
let g:ale_php_phpstan_level = 5
let g:ale_lint_delay = 300
let g:ale_sign_column_always = 1
" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"-----tags usage-----
set tags=tags;
filetype plugin on
set omnifunc=syntaxcomplete#Complete "omnicompletion

"-----window manipulation remaps-----
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
if has('nvim')
	tnoremap <M-h> <c-\><c-n><c-w>h
	tnoremap <M-j> <c-\><c-n><c-w>j
	tnoremap <M-k> <c-\><c-n><c-w>k
	tnoremap <M-l> <c-\><c-n><c-w>l
	tnoremap <c-[> <c-\><c-n>
endif
nnoremap <M-c> <c-w>c
nnoremap <M-o> <c-w>o
nnoremap <M-s> <c-w>s
nnoremap <M-v> <c-w>v
nnoremap <M-b> <c-w>b
nnoremap <M-t> <c-w>t
nnoremap <M--> <c-w>-
nnoremap <M-+> <c-w>+
nnoremap <M-=> <c-w>=
nnoremap <M->> <c-w>>
nnoremap <M-<> <c-w><
nnoremap <M-S-l> <c-w>L
nnoremap <M-S-h> <c-w>H
"-----tab manipulation remaps-----
nnoremap <M-T> <c-w>T
nnoremap <M-n> gt
nnoremap <M-p> gT
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

"-----remove relative numbered lines when opening terminal-----
function! SetNoNumberNoRelativeNumber()
	set norelativenumber
	set nonumber
endfunc

if has('nvim')
	autocmd TermOpen * :call SetNoNumberNoRelativeNumber()
endif


"set hybrid line numbers
set relativenumber
set nu

set wildmode=list:longest,full "extend tab suggestions for :comand

"toggle between relative and absolute number
function! ToggleRelativeNumber()
    if &relativenumber
        set number norelativenumber
    else
        set relativenumber
    endif
endfunction
"use F3 to toggle between rnu and nu
nmap <F5> :call ToggleRelativeNumber()<CR>
"set working directory to allways be the same as the file you are editing
"set autochdir
autocmd BufEnter * silent! lcd %:p:h
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
set background=dark
syntax on
colorscheme gruvbox
"hide background color for nonprintible characters
hi! SpecialKey cterm=none ctermbg=none
set ruler
"always show cursor position with underline
set cul
set laststatus=2
set list
"set Ctrl-D and Ctrl-U to srcoll 10 lines instead of half a page
set scroll=5
nnoremap <C-k> J
nnoremap J 5<C-d>
nnoremap K 5<C-u>
"hi SpecialKey ctermfg=white            hello     
"set listchars=tab:▸\ ,trail:~,extends:>,precedes:<
set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
"set listchars=eol:$,eol:¬,tab:>-,trail:~,extends:>,precedes:<

"-----netrw configuration-----
"let g:netrw_liststyle = 3
"let g:netrw_banner = 0
"let g:netrw_winsize = 15
"let g:netrw_browse_split = 4
"" Toggle Vexplore with Ctrl-E
"function! ToggleVExplorer()
"	if exists("t:expl_buf_num")
"		let expl_win_num = bufwinnr(t:expl_buf_num)
"		if expl_win_num != -1
"			let cur_win_nr = winnr()
"			exec expl_win_num . 'wincmd w'
"			close
"			exec cur_win_nr . 'wincmd w'
"			unlet t:expl_buf_num
"		else
"			unlet t:expl_buf_num
"		endif
"	else
"		exec '1wincmd w'
"		Vexplore
"		let t:expl_buf_num = bufnr("%")
"	endif
"endfunction
"map <silent> <C-E> :call ToggleVExplorer()<CR>

"window rotation
function! RotateLeft()
    let l:curbuf = bufnr('%')
    hide
    wincmd h
    vsplit
    exe 'buf' l:curbuf
endfunc

function! RotateRight()
    let l:curbuf = bufnr('%')
    hide
    wincmd l
    vsplit
    exe 'buf' l:curbuf
endfunc

"map <C-w>H :call RotateLeft()<C-m>
"map <C-w>L :call RotateRight()


"-----indentation settings-----
set tabstop=4
set shiftwidth=4 "Indents will have a width of 4
set softtabstop=4 "Sets the number of columns for a TAB
"set expandtab "Expand TABs to spaces

"show cursor position with underline only when 2+ windows open
"augroup BgHighlight
"autocmd!
"autocmd WinEnter * set cul
"autocmd WinLeave * set nocul
"augroup END
set autoindent
set cindent
set shiftwidth=4

set langmenu=en_US.UTF-8
let $LANG = 'en'

"Remap Escape for kj"
inoremap kj <Esc>
inoremap оо <Esc>
"Auto close brackets"
"inoremap {<CR> {<CR>}<C-o>==<C-o>O
inoremap {<CR> {<CR><CR>}<Esc>kcc
set splitbelow
set splitright
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v./
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
"<C-m> == <CR> (it's magic!)
" nnoremap <C-m> :w<CR>:<C-p><CR>
"For compilating and executing in vim, :make"
"au BufEnter *.c compiler gcc
"set makeprg=gcc\ \-Wall\ \-Wextra\ \-Werror\ %\ &&\ ./a.out
"set makeprg=cd\ \~/ft_printf/\ &&\ make\ re | cw
"set makeprg=gcc\ \-Wall\ \-Wextra\ \-Werror\ libft.a\ %\ &&\ ./a.out\ \\\|\ cat\ \-e
"nnoremap <C-m> :w<CR>:mak<CR>
"For project specific .vimrc files"
set exrc
set secure
"Save folds (actually saves everything you did before exiting vim)"
"au BufWinLeave ?* mkview 1
"au BufWinEnter ?* loadview 1
augroup AutoSaveFolds
	autocmd!
	"view files are about 500 bytes
	"bufleave but not bufwinleave captures closing 2nd tab
	"nested is needed by bufwrite* (if triggered via other autocmd)
	autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
	autocmd BufWinEnter ?* silent! loadview
augroup end
set viewoptions=folds,cursor
set sessionoptions=folds

"For Ukrainian keyboard layout (can't be wrapped in 80 columns)"
set langmap='йцукенгшщзхїфівапролджєячсмитьбю~ЙЦУКЕHГШЩЗХЇФІВАПРОЛДЖЄЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"Set vim colors to 256"
set t_Co=256

"=======================================================================
"=======                        MAPPINGS                        ========
"=======================================================================

"---With snippets---"

"Creating an int    main(void) block by typing in insert mode ;imv"
"inoremap ,imv <Esc>:read $HOME/.vim/snippets/.intmainvoid.c<CR>2jA
autocmd FileType c inoremap ,imv int		main(void)<CR>{<CR><CR><CR>}<Esc>ki	return(0);<Esc>ki	
autocmd FileType cpp inoremap ,imv int		main(void)<CR>{<CR><CR><CR>}<Esc>ki	return 0;<Esc>ki	
"Creating an int    main(int argc, char **argv)"
"inoremap ,imar <Esc>:read $HOME/.vim/snippets/.intmainargcargv.c<CR>2jA
autocmd FileType c inoremap ,imar int		main(int ac, char **av)<CR>{<CR><CR><CR>}<Esc>ki	return(0);<Esc>ki	
autocmd FileType cpp inoremap ,imar int		main(int ac, char **av)<CR>{<CR><CR><CR>}<Esc>ki	return 0;<Esc>ki	

"---Without snippets---"

inoremap ,, <Esc>0/<++><cr>"_c4l<Esc>:noh<CR>a
nnoremap ,, <Esc>0/<++><cr>"_c4l<Esc>:noh<CR>a
"printf(); with parentheses and appropriate cursor position"
inoremap ,pf printf("\n", <++>);<Esc>F\i
autocmd FileType c inoremap ,fpf ft_printf("\n", <++>);<Esc>F\i
autocmd FileType c inoremap ,wr write(1, , <++>);<Esc>F,i
autocmd FileType c inoremap ,wh while ()<CR><++><Esc>ki
autocmd FileType cpp inoremap ,co std::cout <<  << std::endl;<Esc>FsBhi
inoremap ,if if ()<CR><++><Esc>ki
inoremap ,$ $()<++><Esc>F)i
autocmd FileType c inoremap /*<CR> /*<CR><Esc>0c$**<CR>*/<Esc>kA
"Adding symbols around the words
vnoremap ,( c()<Esc>hp
vnoremap ,[ c[]<Esc>hp
vnoremap ,< c<><Esc>hp
vnoremap ," c""<Esc>hp
"Adding and deleting comments for a line
vnoremap ,* c/*<cr>*/<Esc>hP
vnoremap ,d* d"_dkP

"-----php,js remaps and abbrevs-----
inoremap ,? <?php?><Esc>F?i
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap ( ()<Esc>i
autocmd FileType php,javascript inoremap ,f function 
autocmd FileType php inoremap ,pf public function 
autocmd FileType php inoremap ,vd var_dump();<Esc>hi
autocmd FileType javascript,blade,typescript inoremap ,cl console.log();<Esc>hi
autocmd FileType json set tabstop=2

"ABBREVIATIONS"

iabbrev stdioh #include <stdio.h>
iabbrev unistdh #include <unistd.h>
iabbrev stdlibh #include <stdlib.h>
iabbrev stringh #include <string.h>
iabbrev libfth #include <libft.h>
iabbrev ctypeh #include <ctype.h>
iabbrev cursesh #include <curses.h>
iabbrev termh #include <term.h>
iabbrev termiosh #include <termios.h>
iabbrev termcaph #include <termcap.h>
iabbrev fcntlh #include <fcntl.h>
iabbrev systypesh #include <sys/types.h>
iabbrev sysuioh #include <sys/uio.h>
iabbrev sysstath #include <sys/stat.h>
iabbrev syswaith #include <sys/wait.h>
iabbrev direnth #include <dirent.h>
iabbrev signalh #include <signal.h>


"-----cpp-----
autocmd FileType cpp iabbrev iiostream #include <iostream>
autocmd FileType cpp iabbrev istring #include <string>

iabbrev returN return
iabbrev retur return
iabbrev retu return

iabbrev {{ {{ }}<Esc>2hi
