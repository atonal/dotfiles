call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv'
Plug 'kergoth/vim-bitbake'
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nelstrom/vim-visual-star-search'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/ScrollColors'
Plug 'vim-scripts/cmake'
Plug 'junousia/vim-babeltrace'
Plug 'ntpeters/vim-better-whitespace'
Plug 'triglav/vim-visual-increment'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'gustafj/vim-ttcn'
Plug 'brookhong/cscope.vim'
Plug 'Rykka/colorv.vim'
Plug 'atonal/vim-limithi'
call plug#end()

let mapleader=","

if has('mouse')
  set mouse=a
endif

filetype plugin indent on

set nocompatible
set autoindent
set smartindent
set backspace=indent,eol,start
set smarttab
set number
set modeline
set nostartofline
set whichwrap=b,s,h,l,<,>,[,]
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set textwidth=0
" set linebreak
set nrformats-=octal
set hidden
set showcmd
set hlsearch
set incsearch
set wildmenu
set showmode
set spelllang=en_us
set scrolloff=3
set sidescrolloff=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set ignorecase
set smartcase
set background=dark
set t_Co=256
set autoread
set history=1000
set viminfo='1000,f1,:1000,/1000
set encoding=utf8

colorscheme peachpuff
syntax on

set laststatus=2 " Needed to make the statusline visible
"set statusline=%F%=%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=
set statusline+=%<\ " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\ " buffer number, and flags
set statusline+=%-40f\ " relative path
set statusline+=%1*%{fugitive#statusline()}%* " git status
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%= " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\ " file type
set statusline+=%10((%l,%v/%L)%)\ " line and column
set statusline+=%P " percentage of file

noremap <F2> :NERDTreeToggle<CR>

" Switch between header and source file
map <silent> <F4> :A<CR>

" Remove trailing whitespace
nnoremap <silent> <F5> :StripWhitespace<CR>

" Tagbar
nnoremap <silent> <F6> :TagbarToggle<CR>

" Comment / uncomment
map <silent> <F7> gcc

set pastetoggle=<F8>

map <F9> :Gblame<CR>

" F10 and F11 Toggle column boundary
hi ColorColumn ctermbg=darkyellow
nmap <F10> :set colorcolumn=80,120 <CR>
nmap <F11> :set colorcolumn=0 <CR>

map <silent> <F12> ==<Esc><Esc><Esc>

" These steal from "0
nnoremap yiw "wyiw
nnoremap yib "byib
nnoremap yiB "cyiB

" Replace word with previously yanked word
" TODO: doesn't work for the last word of the line
nnoremap <Leader>rw "_diw"wP

" Replace () block with previously yanked block
nnoremap <Leader>rb "_dib"bP

" Replace {} block with previously yanked block
nnoremap <Leader>rB "_diB"cP

nnoremap <Leader>t :call Cscope()<CR>
function! Cscope()
  exe 'silent !build_cscope_db.sh . 1>/dev/null' | exe 'silent cs reset' | redraw!
endfunction

" Clear the highlighting of :set hlsearch.
nnoremap <silent> <Leader>m :nohlsearch<CR>

" Search vim help for the word under cursor
nnoremap <silent> <Leader>vh yiw:h <C-r>"<CR>

nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Open with current directory
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Insert a single char
noremap <Leader>i i<Space><Esc>r

" Select everything
noremap <Leader>gg ggVG

" Move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Traverse buffers
map <C-h> :bp<CR>
map <C-l> :bn<CR>

" Copy to system clipboard
vnoremap <C-c> "*y

" Move between windows
map <M-j> <C-w>j
map <M-h> <C-w>h
map <M-k> <C-w>k
map <M-l> <C-w>l

" Resize window
if bufwinnr(1)
  map + 5<C-W>>
  map - 5<C-W><
endif

" Disable the arrow keys in normal mode
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *N
nnoremap # #nzz
nnoremap g* g*Nzz
nnoremap g# g#nzz

" Save file with root permissions by typing w!!
cmap w!! w !sudo tee % > /dev/null

" Map key to toggle opt
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)
" MapToggle <F10> hlsearch

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Always do a full syntax refresh
autocmd BufEnter * syntax sync fromstart

" For help files make <Return> behave like <C-]> (jump to tag) and quit with q
autocmd FileType help nmap <buffer> <Return> <C-]>
autocmd FileType help nmap <buffer> q :bw<CR>

autocmd BufRead,BufNewFile *.re set filetype=c
autocmd BufRead,BufNewFile *.lttng set filetype=babeltrace
autocmd BufRead,BufNewFile *.bb set filetype=cmake
autocmd BufRead,BufNewFile *.inc set filetype=cmake

autocmd FileType c,cpp set expandtab omnifunc=ccomplete#Complete
autocmd FileType vim set expandtab shiftwidth=2 softtabstop=2
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

autocmd BufRead,BufNewFile *.ttcn set filetype=ttcn
autocmd FileType ttcn setl shiftwidth=2
autocmd FileType ttcn setl tabstop=2
autocmd FileType ttcn setl softtabstop=2
autocmd FileType ttcn setl expandtab

" Plugin options

" Ttcn
:let ttcn_fold=1

" NERDTree
let NERDTreeWinSize = 40
let NERDTreeDirArrows = 1
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" GitGutter
let g:gitgutter_sign_column_always = 1

" Use rainbow parenthesis always
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501 --max-complexity=10'
let g:syntastic_c_checkers = ['cppcheck', 'splint', 'gcc']
let g:syntastic_cpp_checkers = ['cppcheck']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_check_on_open = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_mode_map = { "mode": "passive",
      \ "active_filetypes": ["python"],
      \ "passive_filetypes": [] }

" vim-commentary
" Use // instead of /* */ commenting in C and C++ files
autocmd FileType c set commentstring=//\ %s
autocmd FileType cpp set commentstring=//\ %s
autocmd FileType python set commentstring=#\ %s

" LimitHi
let g:limithi_softlimit=80
let g:limithi_hardlimit=120
let g:limithi_linecolor_hard="ctermbg=Red cterm=bold"
let g:limithi_linecolor_soft="ctermbg=DarkGrey"

" Cscope
let g:cscope_silent=1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" w Find by file name
command! -nargs=1 CscopeFindFile call CscopeFind('f', <f-args>)
nnoremap <Leader>fw :CscopeFindFile 

" Unite
nnoremap <silent> <Leader>um :Unite file_mru<CR>

" better-whitespace
highlight ExtraWhitespace ctermbg=red
