set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" {{{  !! Vundle packages !!
Bundle 'gmarik/vundle'
Bundle 'git://github.com/Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Blackrush/vim-gocode'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'godlygeek/tabular'
Bundle 'Shougo/vimfiler.vim'
Bundle 'scrooloose/syntastic'
Bundle 'kmnk/vim-unite-giti.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'elzr/vim-json'
Bundle 'vim-ruby/vim-ruby'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'rodjek/vim-puppet'
Bundle 'Raimondi/delimitMate'
Bundle 'mattn/emmet-vim'

" Themes
Bundle 'jpo/vim-railscasts-theme'
Bundle 'flazz/vim-colorschemes'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-colorscheme-switcher'
Bundle "daylerees/colour-schemes", { "rtp": "vim/" }

" }}}

 " {{{ !! VISUAL !!
set nocompatible
if has("syntax")
  syntax on
endif

set tabstop=2
set shiftwidth=2
set laststatus=2
set gcr=a:blinkon0
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set shortmess=atI

" Add go syntax
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
filetype on


" {{{  Intendation
"set autoindent
"set smartindent
"set cindent
" }}}

set cursorline

if exists("&rnu")
  set rnu
end

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set t_Co=256

colorscheme Tomorrow-Night
set background=dark
" {{{ !! colors !!
if has("gui_macvim")
  "set guifont=Liberation\ Mono:h12
  set guifont=Anonymous\ Pro:h14
  "colorscheme codeschool
  "colorscheme github
  "colorscheme liquidcarbon
  "colorscheme mac_classic
  "colorscheme railscasts2
  "colorscheme BusyBee
  "colorscheme xoria256
  "colorscheme mustang
  set guioptions=aAce
  "set transparency=10
  map <D-1> :tabfirst<Cr>
  map <D-2> :tabfirst<Cr>gt
  map <D-3> :tabfirst<Cr>3gt
  map <D-4> :tabfirst<Cr>4gt
else
  "colorscheme newspaper
endif

" Individual highlights
highlight EndSpaces ctermbg=167
match EndSpaces /\s\+$/

" highlight PMenu ctermbg=238 gui=bold

" set hlsearch
" }}}

" }}}

" {{{ Other important stuff :)
set dir=~/.vim/swapfiles/
compiler ruby

if exists("&autochdir")
  set autochdir
end

set backspace=indent,eol,start
" }}}

" {{{ Functions
function! ToggleLineNum()
  if exists("&rnu")
    if &number
      setlocal relativenumber
    else
      setlocal number
    endif
  else
    setlocal number!
  endif
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"nmap<silent> <D-i> :CommandT<cr>
"imap<silent> <D-i> <C-O><D-i>
"nmap<silent> <D-u> :CommandT<cr>
"imap<silent> <D-u> <C-O><D-u>

nmap<silent> <F1> :set list!<cr>
imap<silent> <F1> <C-O><F1>

nmap<silent> <F2> :call ToggleLineNum()<cr>
imap<silent> <F2> <C-O><F2>

set pastetoggle=<F3>
map <F4> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F5> :VimFilerExplorer<CR>
nnoremap <F6> :Unite buffer<CR>
nnoremap <F7> :Unite file buffer<CR>
nnoremap <F8> :Unite bookmark<CR>
nnoremap <F9> :TagbarToggle<CR>

nmap<silent> <Tab> %

nnoremap <C-W>O :call MaximizeToggle ()<CR>
nnoremap <C-W>o :call MaximizeToggle ()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle ()<CR>

noremap YY ^yg_

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
" }}}
"
set wildchar=<Tab> wildmenu wildmode=full
" set clipboard=unnamed

au BufRead,BufNewFile COMMIT_EDITMSG     setf git

" {{{ !! Viki Mappings !!
au BufRead,BufNewFile *.wiki set ft=viki
au FileType viki map ]f \vf
au FileType viki map ]b \vb
au FileType viki folddoclosed foldopen
" }}}
"
"automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

au BufRead,BufNewFile *.json set ft=json

"
" {{{ !! Mappings !!
au FileType vim set foldmethod=marker

map ,v :sp ~/.vimrc<cr>
map ,u :source ~/.vimrc<cr>

map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>

" Tab mappings
"map ,t :tabnew<cr>

" }}}

" {{{ !! NERDTree !!
let NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything
" }}}

" {{{ !! vim-slime !!
let g:slime_target = "tmux"
" }}}

"{{{!! puppet !!!
au BufRead,BufNewFile *.pp set sw=2 ts=2 expandtab cindent
"}}}

"{{{!! json
au BufRead,BufNewFile *.json set sw=2 ts=2 expandtab
"}}}

" {{{ !! ruby !!
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby set shiftwidth=2
autocmd FileType ruby,eruby set tabstop=2
autocmd FileType ruby,eruby set expandtab
" }}}

" {{{ !! python !!
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
" }}}
" {{{ !! haml, sass !!
autocmd FileType haml,sass set shiftwidth=2 tabstop=2 noexpandtab
" }}}

" {{{ !! sudo !!
command! -bar -nargs=0 SudoW   :silent exe "write !sudo tee % >/dev/null"|silent edit!
" }}}
"
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" {{{ !! grep plugin !!
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
    else
        execute "copen"
    endif
endfunction

" Used to track the quickfix window.
augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END
" }}}

" Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_check_on_open=1

let g:syntastic_puppet_puppetlint_args='--no-autoloader_layout-check --no-80chars-check --no-names_containing_dash-check --no-documentation-check --no-class_parameter_defaults-check'
let g:syntastic_javascript_checkers = ['jslint']


" VimFiler
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

" Tagbar
let g:tagbar_iconchars = ['▸', '▾']


" {{{ Status line -- we don't use it, we use vim-airline
" function! InsertStatuslineColor(mode)
"   if a:mode == 'i'
"     hi statusline guibg=#857b6f
"   elseif a:mode == 'r'
"     hi statusline guibg=blue
"   else
"     hi statusline guibg=red
"   endif
" endfunction
" 
" au InsertEnter * call InsertStatuslineColor(v:insertmode)
" au InsertChange * call InsertStatuslineColor(v:insertmode)
" au InsertLeave * hi statusline guibg=#f6f3e8
" 
" " default the statusline to green when entering Vim
" hi statusline guibg=#f6f3e8
" }}}
"
"
" {{{ Unite plugin awesomeness
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>

let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>

nnoremap <space>s :Unite -quick-match buffer<cr>

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <space>fc :Unite file buffer<CR>
nnoremap <space>fb :Unite buffer<CR>
nnoremap <space>b :Unite bookmark<CR>
" }}}

" {{{ Indentline plugin
let g:indentLine_char = '│'
let g:indentLine_color_gui = '#444444'
" }}}

" JSON plugin
let g:vim_json_syntax_conceal = 0
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
