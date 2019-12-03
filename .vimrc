if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" <<<Base stuff>>>
Plug 'morhetz/gruvbox'
" Plug 'vim-airline/vim-airline'

" This is a fork, the original version does not work properly with fugitive
" displaying of git branches.
Plug 'YCbCr/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'hecal3/vim-leader-guide'

" <<<Code completion, refactoring and goto definition>>>
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'phpactor/ncm2-phpactor'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
" Plug 'beanworks/vim-phpfmt' "psr formatting
Plug 'stephpy/vim-php-cs-fixer'

" dock block generation
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'

Plug '/Users/dpolosuk/.brew/opt/fzf'
Plug 'junegunn/fzf.vim'

" <<<Git>>>
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'shawncplus/phpcomplete.vim'
Plug 'StanAngeloff/php.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'jwalton512/vim-blade'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-commentary'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mkitt/tabline.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'w0rp/ale'
" Plug 'lumiliet/vim-twig'
Plug 'nelsyeung/twig.vim'
Plug 'vim-vdebug/vdebug'
Plug 'tpope/vim-surround'

Plug 'ekalinin/Dockerfile.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
call plug#end()

"=====airline=====

" enable fugitive integration
let g:airline_powerline_fonts = 1 " arrows >
let g:airline#extensions#fugitiveline#enabled = 1 " for git integration
let g:airline#extensions#branch#enabled = 1 " for showing the branch name
let g:airline#extensions#hunks#enabled = 1 " for showing different git changes
let g:airline#extensions#branch#format = 2 " f/branch instead of feature/branch
let g:airline#extensions#branch#sha1_len = 5
" fallback method of showing branch name
" let g:airline_section_b = '%{FugitiveStatusline()}'

"=====NERDtree=====

map <C-E> :NERDTreeToggle<CR>
"close vim if only NERDtree window is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"enable line numbers
let NERDTreeShowLineNumbers=1
"make shure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"=====VIM-Leader-Guide=====

" Leader key <SPACE>
let mapleader=","
" Leader guide configuration.
let g:lmap =  {}
" Leader for buffers
let g:lmap.b = {
    \'name': 'Buffers',
    \'l':  [':Buffers', 'List buffers'],
    \}

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

"=====Code completion, refactoring and goto definition=====

" Set the PHP bin to an additional installation that has no XDEBUG installed
let g:phpactorPhpBin = '/usr/bin/php71'

" Make ncm2 work automatically
autocmd BufEnter * call ncm2#enable_for_buffer()
" When autocompleting auto select the first one and do not autoinsert.
set completeopt=noinsert,menuone,noselect

" Enable tab cyle thorought suggestions.
" ctrl + j: Next item (down).
" ctrl + k: Previous item (up).
" inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" When pressing CTRL+u on a suggestion, it will expand with parameters.
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" Tab and Shift-Tab will cycle thorough parameters.
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" phpactor stuff
let g:lmap.k = {
    \'name': 'PhpActor',
    \'b': ['call phpactor#ClassExpand()', 'ExpandClass'],
    \'c': ['call phpactor#CopyFile()', 'Copy file'],
    \'d': ['call phpactor#GotoDefinition()', 'Go to definition'],
    \'e': ['call phpactor#mxtractMethod()', 'Extract method'],
    \'f': ['call phpactor#FindReferences()', 'Find references'],
    \'k': ['call phpactor#ContextMenu()', 'Menu'],
    \'h': ['call phpactor#Hover()', 'Hover'],
    \'i': ['call phpactor#ClassInflect()', 'Inflect'],
    \'l': ['call phpactor#ClassNew()', 'New class'],
    \'m': ['call phpactor#MoveFile()', 'Move file'],
    \'n': ['call phpactor#Navigate()', 'Navigate'],
    \'t': ['call phpactor#Transform()', 'Transform/Complete'],
    \'u': ['call phpactor#UseAdd()', 'UseAdd'],
    \}
nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>

"=====fzf-search=====

function! s:find_git_root()
	return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

" searching with a preview and include gitignored files.
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, '--skip-vcs-ignores',
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%'),
      \                 <bang>0)

" Search word under cursor.
nnoremap <Plug>(search-cursor-word) :Ag <C-R><C-W><CR>
nmap <leader>sw <Plug>(search-cursor-word)

" Search tags for cursor word.
nnoremap <Plug>(search-cursor-word-tags) :Tags <C-R><C-W><CR>
nmap <leader>st <Plug>(search-cursor-word-tags)

" History of opened files.
nnoremap <Plug>(file-history) :History<CR>
nmap <leader>h <Plug>(file-history)

" Search history.
nnoremap <Plug>(search-history) :History/<CR>
nmap <leader>sh <Plug>(search-history)

" Ctrl + L, list open buffers. I use this alot.
nmap <C-l> :Buffers<CR>

" Fuzzy find files in current folder.
map <C-M> :FZF<CR>
" Fuzzy find files in whole project.
nnoremap <C-P> :ProjectFiles<CR>

"=====psr formatting=====
" let g:phpfmt_standard = 'PSR2'
" let g:phpfmt_command = '/home/dornat/.config/composer/vendor/bin/phpcbf'
set redrawtime=10000
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
let g:php_cs_fixer_php_path = "/usr/bin/php"      " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.



"=====Syntastic=====
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"=====vim-closetag=====
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.php'

"=====cpp-syntax=====
let g:cpp_class_scope_highlight = 1

"=====markdown-preview=====
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1
" let vim_markdown_preview_hotkey='<leader>m'

"=====ale======
" let g:ale_linters = {
" 	\'javascript': ['eslint'],
" 	\'php': 'all',
" \ }
" let g:ale_php_phpstan_configuration = "/home/dornat/.config/phpstan/phpstan.neon"
" let g:ale_php_phpstan_level = 5
" let g:ale_lint_delay = 500
" let g:ale_sign_column_always = 1
"
" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

"=====Vdebug=====
let g:vdebug_options= {
    \    "port" : 9000,
    \    "server" : '',
    \    "timeout" : 200,
    \    "on_close" : 'detach',
    \    "break_on_open" : 0,
    \    "ide_key" : 'docker',
    \    "path_maps" : {"/var/www/html/zenith": "/home/dornat/Programming/dockerEnviroment/sites/ubuntu-7/zenith"},
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'compact',
    \    "marker_default" : '⬦',
    \    "marker_closed_tree" : '▸',
    \    "marker_open_tree" : '▾',
    \   "window_commands": {
    \     'DebuggerWatch': 'vertical belowright new',
    \     'DebuggerStack': 'belowright new +res5',
    \     'DebuggerStatus': 'belowright new +res5'
    \   },
    \ }


"=====pdv=====
let g:pdv_template_dir = "/home/dornat/.vim/plugged/pdv/templates_snip"
" nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

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

"-----horizontal scrolling when wrap is off-----
set nowrap
nnoremap <C-f> 10zl
nnoremap <C-b> 10zh

"-----invoke sudo on file-----
command W w !sudo tee "%" > /dev/null

"-----persistent undo-----
set undofile
set undodir=~/.config/nvim/undodir

"set hybrid line numbers
set relativenumber
set nu
" set lazyredraw

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
"nmap <F5> :call ToggleRelativeNumber()<CR>
"set working directory to allways be the same as the file you are editing
"set autochdir
autocmd BufEnter * silent! lcd %:p:h
" nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
set background=dark
syntax on
colorscheme gruvbox
"hide background color for nonprintible characters
hi! SpecialKey cterm=none ctermbg=none
set ruler
"always show cursor position with underline
" set cul
set laststatus=2
set list
"set Ctrl-D and Ctrl-U to srcoll 5 lines instead of half a page
set scroll=5
nnoremap <C-k> J
nnoremap J 5<C-d>
nnoremap K 5<C-u>
"hi SpecialKey ctermfg=white            hello     
"set listchars=tab:▸\ ,trail:~,extends:>,precedes:<
set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
"set listchars=eol:$,eol:¬,tab:>-,trail:~,extends:>,precedes:<

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

"-----indentation settings-----
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set softtabstop=4 "Sets the number of columns for a TAB

set autoindent
set cindent

set langmenu=en_US.UTF-8
let $LANG = 'en'

"Remap Escape for jk"
inoremap jk <Esc>
inoremap ол <Esc>
"Auto close brackets"
"inoremap {<CR> {<CR>}<C-o>==<C-o>O
inoremap {<CR> {<CR><CR>}<Esc>kcc
set splitbelow
set splitright

set nofoldenable
" Highlighting lines that more than 81 columngs long.
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v./
" augroup vimrc
" au BufReadPre * setlocal foldmethod=indent
" au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END
"Remap folds opening"
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"Remap for easy buffer switch"
" nnoremap <C-n> :bnext<CR>
" nnoremap <C-p> :bprevious<CR>
"For project specific .vimrc files"
set exrc
set secure


augroup AutoSaveFolds
    autocmd!
    "view files are about 500 bytes
    "bufleave but not bufwinleave captures closing 2nd tab
    "nested is needed by bufwrite* (if triggered via other autocmd)
    autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
    autocmd BufWinEnter ?* silent! loadview
augroup end

"For Ukrainian keyboard layout"
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

"-----php,js remaps and abbrevs-----
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
