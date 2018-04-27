if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv'
Plug 'kergoth/vim-bitbake'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nelstrom/vim-visual-star-search'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-salve'
Plug 'guns/vim-clojure-static'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/ScrollColors'
Plug 'vim-scripts/cmake'
Plug 'junousia/vim-babeltrace'
Plug 'ntpeters/vim-better-whitespace'
Plug 'triglav/vim-visual-increment'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'gustafj/vim-ttcn'
Plug 'Rykka/colorv.vim'
Plug 'atonal/vim-limithi'
Plug 'benjumanji/vim-togglelist'
Plug 'brookhong/cscope.vim'
Plug 'neovimhaskell/haskell.vim'
Plug 'mfukar/robotframework-vim'
Plug 'elzr/vim-json'
Plug 'keith/tmux.vim'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'plasticboy/vim-markdown'
Plug 'lepture/vim-jinja'
Plug 'pangloss/vim-javascript'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'bazelbuild/vim-ft-bzl'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'gavocanov/vim-js-indent'
Plug 'kien/rainbow_parentheses.vim'
"Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'sickill/vim-sunburst'
Plug 'sickill/vim-monokai'
Plug 'ciaranm/inkpot'
Plug 'vim-scripts/Wombat'
Plug 'vim-scripts/wombat256.vim'
Plug 'nanotech/jellybeans.vim'
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

"colorscheme pleasant
"colorscheme pw
colorscheme desert

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

map <F9> :Gblame<CR>

map <silent> <F11> ==<Esc><Esc><Esc>

set pastetoggle=<F12>

inoremap jj <esc>
cnoremap jj <c-c>

" Store some yanked stuff into specific registers
nnoremap <silent> yiw yiw:let @w=@"<CR>
nnoremap <silent> yib yib:let @b=@"<CR>
nnoremap <silent> yiB yiB:let @c=@"<CR>

" Replace word with previously yanked word
nnoremap <Leader>w "_ciw<C-R>w<Esc>

" Replace () block with previously yanked block
nnoremap <Leader>b "_dib"bP

" Replace {} block with previously yanked block
nnoremap <Leader>B "_diB"cP

" Replace {motion} with given register, e.g. ,ribw replaces inner () block with "w
nmap <silent> <Leader>r :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
let s = InputChar()
    if s =~ "\<esc>" || s =~ "\<c-c>"
        return
    endif
if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>\"_c" . getreg(s)
elseif a:type == 'line'
    silent exe "normal! '[V']\"_c" . getreg(s)
elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]\"_c" . getreg(s)
else
    silent exe "normal! `[v`]\"_c" . getreg(s)
endif
endfunction

function! InputChar()
    let c = getchar()
    return type(c) == type(0) ? nr2char(c) : c
endfunction

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
noremap <Leader>G ggVG

" Move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Join line above the current line
nnoremap <Leader>J :m .-2<CR>J

" Split long function call to multiple lines
nnoremap <Leader>s mx:s/\((\\|,\)\s*/\1\r/g<CR>V'x=:nohl<CR>

" Traverse buffers
map <C-h> :bp<CR>
map <C-l> :bn<CR>

" Copy to system clipboard
vnoremap <C-c> "*y

" map ö and Ö to :
exe "nmap <Char-246> :"
exe "nmap <Char-214> :"

" Move between windows with <C-S-*>
map <ESC>[72;5u <C-W>h
map <ESC>[74;5u <C-W>j
map <ESC>[75;5u <C-W>k
map <ESC>[76;5u <C-W>l

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

" yank file name to "*, so that it can be pasted outside vim too
nnoremap <leader>y <nop>
nnoremap <leader>yf :let @* = expand("%")<CR>

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

autocmd BufRead,BufNewFile *.re set filetype=c
autocmd BufRead,BufNewFile *.lttng set filetype=babeltrace
autocmd BufRead,BufNewFile *.bb set filetype=cmake
autocmd BufRead,BufNewFile *.inc set filetype=cmake
autocmd BufRead,BufNewFile *.robot set filetype=robot
autocmd BufRead,BufNewFile *.j2 set filetype=jinja

" For help files make <Return> behave like <C-]> (jump to tag) and quit with q
autocmd FileType help nmap <buffer> <Return> <C-]>
autocmd FileType help nmap <buffer> q :bw<CR>

autocmd FileType qf nmap <buffer> <silent> <cr> <cr>:ccl<cr>
autocmd FileType qf nmap <buffer> <silent> q :ccl<cr>

autocmd FileType c setl shiftwidth=4
autocmd FileType c setl tabstop=4
autocmd FileType c setl softtabstop=4
autocmd FileType c setl expandtab
autocmd FileType c setl omnifunc=ccomplete#Complete

autocmd FileType cpp setl shiftwidth=4
autocmd FileType cpp setl tabstop=4
autocmd FileType cpp setl softtabstop=4
autocmd FileType cpp setl expandtab
autocmd FileType cpp setl omnifunc=ccomplete#Complete

autocmd FileType vim setl shiftwidth=2
autocmd FileType vim setl tabstop=2
autocmd FileType vim setl softtabstop=2
autocmd FileType vim setl expandtab

autocmd FileType make setl shiftwidth=4
autocmd FileType make setl tabstop=4
autocmd FileType make setl softtabstop=4
autocmd FileType make setl noexpandtab

autocmd FileType cmake setl shiftwidth=4
autocmd FileType cmake setl tabstop=4
autocmd FileType cmake setl softtabstop=4
autocmd FileType cmake setl expandtab

autocmd FileType sh setl shiftwidth=4
autocmd FileType sh setl tabstop=4
autocmd FileType sh setl softtabstop=4
autocmd FileType sh setl expandtab

autocmd FileType python setl shiftwidth=4
autocmd FileType python setl tabstop=4
autocmd FileType python setl softtabstop=4
autocmd FileType python setl expandtab

autocmd BufRead,BufNewFile *.ttcn set filetype=ttcn
autocmd FileType ttcn setl shiftwidth=2
autocmd FileType ttcn setl tabstop=2
autocmd FileType ttcn setl softtabstop=2
autocmd FileType ttcn setl expandtab

autocmd FileType haskell setl shiftwidth=8
autocmd FileType haskell setl tabstop=8
autocmd FileType haskell setl softtabstop=8
autocmd FileType haskell setl expandtab

autocmd FileType text setl tw=78
autocmd FileType text setl fo+=t

autocmd FileType yaml setl shiftwidth=2
autocmd FileType yaml setl tabstop=2
autocmd FileType yaml setl softtabstop=2
autocmd FileType yaml setl expandtab

autocmd FileType typescript setl shiftwidth=2
autocmd FileType typescript setl tabstop=2
autocmd FileType typescript setl softtabstop=2
autocmd FileType typescript setl expandtab

autocmd FileType javascript setl shiftwidth=2
autocmd FileType javascript setl tabstop=2
autocmd FileType javascript setl softtabstop=2
autocmd FileType javascript setl expandtab

autocmd FileType json setl shiftwidth=2
autocmd FileType json setl tabstop=2
autocmd FileType json setl softtabstop=2
autocmd FileType json setl expandtab

autocmd FileType html setl shiftwidth=2
autocmd FileType html setl tabstop=2
autocmd FileType html setl softtabstop=2
autocmd FileType html setl expandtab

autocmd FileType css setl shiftwidth=2
autocmd FileType css setl tabstop=2
autocmd FileType css setl softtabstop=2
autocmd FileType css setl expandtab

autocmd FileType bzl setl shiftwidth=2
autocmd FileType bzl setl tabstop=2
autocmd FileType bzl setl softtabstop=2
autocmd FileType bzl setl expandtab

" Plugin options

" Ttcn
:let ttcn_fold=1

" NERDTree
let NERDTreeWinSize = 40
let NERDTreeDirArrows = 1
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" GitGutter
set signcolumn=yes

" Use rainbow parenthesis always
autocmd VimEnter * silent! RainbowParenthesesToggle
autocmd Syntax * silent! RainbowParenthesesLoadRound
autocmd Syntax * silent! RainbowParenthesesLoadSquare
autocmd Syntax * silent! RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['lightblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['yellow',      'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['lightblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

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
let g:syntastic_yaml_checkers = ['jsyaml','yamlxs']
let g:syntastic_check_on_open = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_mode_map = { "mode": "passive",
      \ "active_filetypes": ["python", "sh"],
      \ "passive_filetypes": [] }

" vim-commentary
" Use // instead of /* */ commenting in C and C++ files
autocmd FileType c set commentstring=//\ %s
autocmd FileType cpp set commentstring=//\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType groovy set commentstring=//\ %s

" LimitHi
let g:limithi_softlimit=80
let g:limithi_hardlimit=120
let g:limithi_linecolor_hard="ctermbg=1, ctermfg=254"
let g:limithi_linecolor_soft="ctermbg=234"

" Cscope
let g:cscope_silent=1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
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

nnoremap <leader>l :call ToggleLocationList()<CR>

" Unite
" Use start insert by default.
silent! call unite#custom#profile('default', 'context', {
\   'start_insert' : 1
\ })
nnoremap <silent> <Leader>u <nop>
nnoremap <silent> <Leader>um :Unite file_mru<CR>
nnoremap <silent> <Leader>ub :Unite buffer<CR>
nnoremap <silent> <Leader>uf :Unite file<CR>
nnoremap <silent> <Leader>ur :Unite file_rec<CR>

" better-whitespace
highlight ExtraWhitespace ctermbg=red

" Indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=232

" a.vim
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"

" vim-togglelist
let g:toggle_list_restore = 0

" vim-json
let g:vim_json_syntax_conceal = 0

" fugitive
noremap <silent> <Leader>g <nop>
noremap <Leader>gw :Ggrep <cword><CR>
noremap <Leader>gf :Ggrep %:t<CR>
noremap <Leader>gs :Gstatus<CR>
" Ggrep {motion}, e.g. ,ggiB to grep "foobar = 3" from {foobar = 3}
" Doesn't work for multiline patterns. Also visual modes fail.
noremap <silent> <Leader>gg :set opfunc=GgrepMotion<CR>g@
function! GgrepMotion(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
    else
        silent exe "normal! `[v`]y"
    endif

    exe "Ggrep \"" . @@ . "\""

    let &selection = sel_save
    let @@ = reg_save
endfunction

" vim-markdown
let g:vim_markdown_folding_disabled = 1
