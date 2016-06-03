if &compatible
  set nocompatible
endif

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
  scriptencoding utf-8
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

Plug 'tpope/vim-fugitive'

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" let g:fzf_action = {
"   \ 'ctrl-s': 'split',
"   \ 'ctrl-v': 'vsplit' }
" let g:fzf_layout = { 'up': '~20%' }
" let g:fzf_command_prefix = 'Fzf'
" nmap <Space> [FZF]
" nnoremap <silent> [FZF]b :<C-u>FzfBuffer<CR>
" nnoremap <silent> [FZF]c :<C-u>FzfHistory:<CR>
" nnoremap <silent> [FZF]g :<C-u>FzfAg<CR>
" nnoremap <silent> [FZF]h :<C-u>FzfHistory<CR>
" nnoremap <silent> [FZF]l :<C-u>FzfLines<CR>
" nnoremap <silent> [FZF]p :<C-u>FzfFiles<CR>
" nnoremap <silent> [FZF]s :<C-u>FzfHistory/<CR>
" " nnoremap <silent> [FZF]r :<C-u>Unite -buffer-name=register register<CR>
" " nnoremap <silent> [FZF]q :<C-u>Unite -no-quit location_list -winheight=10<CR>

" nnoremap <expr> [FZF]q fzf#complete('ls -la ')

Plug 'thinca/vim-template'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

Plug 'thinca/vim-visualstar'

Plug 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

Plug 'mopp/autodirmake.vim'

Plug 'nanotech/jellybeans.vim'

" Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }

Plug 'mopp/autodirmake.vim'

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1
set laststatus=2
let g:airline_theme='jellybeans'

Plug 'othree/yajs.vim', { 'for': ['javascript'] }

Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript'] }
let g:used_javascript_libs = 'underscore,react'

Plug 'moll/vim-node', { 'for': ['javascript'] }
autocmd User Node
      \ if &filetype == "javascript" |
      \   nnoremap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
      \   nnoremap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
      \ endif

Plug 'tpope/vim-commentary'

Plug 'thinca/vim-quickrun'
nmap <Leader>r <Plug>(quickrun)
let g:quickrun_config = {
      \ '_': {
      \   'runner': 'vimproc',
      \   'runner/vimproc/updatetime': 10,
      \ },
      \ 'go': {
      \   'command': 'go',
      \   'exec': ['%c run %s'],
      \ },
      \ 'markdown': {
      \   'outputter': 'browser'
      \ },
      \ 'javascript': {
      \   'command': 'node',
      \   'tempfile': '{tempname()}.js'
      \ },
      \ 'javascript/mocha': {
      \   'command': 'mocha',
      \   'tempfile': '{tempname()}.js'
      \ }}

if has('nvim')
  Plug 'Shougo/deoplete.nvim'
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:python_host_prog = expand('$HOME') . '/.pyenv/shims/python'
  let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'

  inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

  set completeopt+=noinsert
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  """ deoplete-go
  let g:deoplete#sources#go#align_class = 1
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
  let g:deoplete#sources#go#package_dot = 1
  let g:deoplete#sources#omni#functions.typescript = [
        \ 'tsuquyomi#complete',
        \ ]


  Plug 'zchee/deoplete-go', { 'do': 'make', 'for': ['go'] }

else
  Plug 'Shougo/neocomplete.vim'
  let g:loaded_deoplete = 1
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ }

  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif

  if !exists('g:neocomplete#sources#omni#functions')
    let g:neocomplete#sources#omni#functions = {}
  endif

  let g:neocomplete#sources#omni#functions.cs = [
        \ 'OmniSharp#Complete',
        \ ]
  " 'tern#Complete',
  let g:neocomplete#sources#omni#functions.javascript = [
        \ 'tern#Complete',
        \ 'javascriptcomplete#CompleteJS',
        \ ]
  let g:neocomplete#sources#omni#functions.typescript = [
        \ 'tsuquyomi#complete',
        \ ]

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'
endif

Plug 'Shougo/neosnippet.vim'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \ : "\<TAB>"
let g:neosnippet#snippets_directory = '~/snippets, /Users/a12121/src/github.com/yukidarake/vim-go/gosnippets/snippets/'
let g:neosnippet#disable_runtime_snippets = {
      \ 'javascript' : 1,
      \ }
Plug 'Shougo/neosnippet-snippets'

Plug 'Shougo/neomru.vim'

Plug 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1
let g:unite_options_auto_highlight = 1
let g:unite_source_rec_async_command = [
  \ 'ag', '--follow', '--nocolor', '--nogroup',
  \  '--hidden', '-g', '']
" let g:unite_source_rec_find_args = [
"   \ '-regex', '".*/\."', '-o', '-path', '"*node_modules',
"   \ '-prune', '-o', '-type', 'l', '-print']
" let g:unite_source_rec_max_cache_files=20000
" let g:unite_source_rec_min_cache_files=100
nnoremap [Unite] <Nop>
nmap <Space> [Unite]
imap <C-c> <Plug>(unite_exit)
nmap <C-c> <Plug>(unite_exit)

function! DispatchUniteFileRec()
  if isdirectory(getcwd()."/.git")
    Unite file_rec/git
  else
    Unite file_rec/async
  endif
endfunction

nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Unite]h :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]p :<C-u>call DispatchUniteFileRec()<CR>
nnoremap <silent> [Unite]<Space> :<C-u>UniteResume<CR>
nnoremap <silent> [Unite]g :<C-u>Unite -no-quit -winheight=10 grep:<CR>
nnoremap <silent> [Unite]q :<C-u>Unite -no-quit location_list -winheight=10<CR>
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-S --nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" 選択した文字列をunite-grep
" https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-i:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

nnoremap <silent> [Unite]l :<C-u>Unite line<CR>
nnoremap <silent> [Unite]j :<C-u>Unite jump<CR>
nnoremap <silent> [Unite]o :<C-u>Unite -winheight=15 outline<CR>
nnoremap <silent> [Unite]c :<C-u>Unite history/command<CR>
nnoremap <silent> [Unite]s :<C-u>Unite history/search<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>

Plug 'Shougo/context_filetype.vim'

Plug 'Shougo/unite-outline'

Plug 'thinca/vim-unite-history'

Plug 'osyo-manga/unite-quickfix'

Plug 'thinca/vim-qfreplace', { 'for': ['unite', 'quickfix'] }

Plug 'fatih/vim-go', { 'for': ['go'] }
let g:go_fmt_command = 'goimports'
let g:go_disable_autoinstall = 0
let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 1 " use syntasitic to check errors
let g:go_play_open_browser = 0
let g:go_snippet_engine = 'neosnippet'

if has('nvim')
  Plug 'neomake/neomake'
  autocmd! BufWritePost * Neomake
  autocmd! FileType go
    \ let s:goargs = go#package#ImportPath(expand('%:p:h'))
    \ let g:neomake_go_errcheck_maker = {
      \ 'args': ['-abspath', s:goargs],
      \ 'append_file': 0,
      \ 'errorformat': '%f:%l:%c:\ %m, %f:%l:%c\ %#%m',
      \ }
    \ let g:neomake_go_enabled_makers = ['golint', 'govet', 'errcheck']

  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_warning_sign = {
    \ 'text': '💩',
    \ 'texthl': 'WarningMsg',
    \ }
  let g:neomake_error_sign = {
    \ 'text': '🔥',
    \ 'texthl': 'ErrorMsg',
    \ }
else
  Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_loc_list=2
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_css_checkers=['csslint']
  let g:syntastic_json_checkers=['jsonlint']
  let g:syntastic_javascript_checkers=['eslint']
  let g:syntastic_python_checkers = ['flake8']
  " For TypeScript
  let g:tsuquyomi_disable_quickfix = 1
  let g:syntastic_typescript_checkers = ['tsuquyomi'] "
  let g:syntastic_html_tidy_ignore_errors=[' proprietary attribute "ng-']
  let g:syntastic_go_checkers = ['go', 'golint', 'govet']
  let g:syntastic_error_symbol = '✕'
  let g:syntastic_style_error_symbol = '✕'
  let g:syntastic_warning_symbol = '△'
  let g:syntastic_style_warning_symbol = '△'
  highlight link SyntasticErrorSign SignColumn
  highlight link SyntasticWarningSign SignColumn
  highlight link SyntasticStyleErrorSign SignColumn
  highlight link SyntasticStyleWarningSign SignColumn
endif


augroup MyGoAutocmd
  au!
  au FileType go nmap <LocalLeader>i <Plug>(go-info)
  au FileType go nmap <LocalLeader>gd <Plug>(go-doc)
  au FileType go nmap <LocalLeader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <LocalLeader>r <Plug>(go-run)
  au FileType go nmap <LocalLeader>b <Plug>(go-build)
  au FileType go nmap <LocalLeader>t <Plug>(go-test)
  au FileType go nmap <LocalLeader>c <Plug>(go-coverage)
  au FileType go nmap <LocalLeader>gb <Plug>(go-build)
  au FileType go nmap <LocalLeader>gt <Plug>(go-test)
  " au FileType go nmap <LocalLeader>d <Plug>(go-def)
  au FileType go nmap <LocalLeader>ds <Plug>(go-def-split)
  au FileType go nmap <LocalLeader>dv <Plug>(go-def-vertical)
  au FileType go nmap <LocalLeader>gl :GoLint<CR>
augroup END

Plug 'cespare/vim-toml', { 'for': ['toml'] }

Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }

Plug 'ternjs/tern_for_vim', { 'do': 'npm i', 'for': ['javascript'] }
nnoremap <LocalLeader>tt :TernType<CR>
nnoremap <LocalLeader>td :TernDef<CR>
nnoremap <LocalLeader>tpd :TernDefPreview<CR>
nnoremap <LocalLeader>tsd :TernDefSplit<CR>
nnoremap <LocalLeader>ttd :TernDefTab<CR>
nnoremap <LocalLeader>tr :TernRefs<CR>:lclose<CR>:Unite -no-quit -winheight=10 location_list<CR>
nnoremap <LocalLeader>tR :TernRename<CR>
nnoremap <LocalLeader>j :TernDef<CR>f'gf
let g:tern_show_argument_hints='on_hold'

Plug 'mxw/vim-jsx', { 'for': ['javascript'] }

Plug 'tpope/vim-markdown', { 'for': ['markdown'] }

Plug 'digitaltoad/vim-jade', { 'for': ['jade'] }

Plug 'thinca/vim-ft-svn_diff'

Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript'] }
let g:jsdoc_default_mapping=0
nnoremap <silent> <C-J> :JsDoc<CR>
nnoremap <silent> <C-Q> :JsDoc<CR>

Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'Quramy/tsuquyomi', { 'for': ['typescript'] }
" if exists('*TSScompleteFunc') && &omnifunc ==# ''
"   augroup MyTSAutocmd
"     au!
"     au FileType typescript setlocal omnifunc=TSScompleteFunc
"   augroup END
" endif

Plug 'chrisbra/vim-diff-enhanced'

Plug 'tyru/open-browser.vim'

Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja'] }

Plug 'pearofducks/ansible-vim', { 'for': ['yaml'] }

Plug 'editorconfig/editorconfig-vim'

call plug#end()

" prefix key
let g:mapleader = '\'
let g:maplocalleader = ','

" let colorscheme = 'Tomorrow-Night-Eighties'
let colorscheme = 'jellybeans'

set nrformats-=octal "<C-A>で8進数の計算をさせない
set clipboard+=unnamed
set noswapfile
set backupdir=$HOME/.vim/backup
set incsearch
set ignorecase smartcase
set ts=2 sw=2 sts=2 sr et ai

set list
set listchars=tab:»-,trail:»,eol:↲,extends:»,precedes:«,nbsp:%
set history=200
set number
set backspace=indent,eol,start
set ruler
set showmatch
set showmode
set virtualedit+=block " http://vim-users.jp/2010/02/hack125/
set title
set wildmenu " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmode=list:longest " コマンドライン補間をシェルっぽく
set cursorline " カーソル行表示
set hidden
set fdm=manual
set nofoldenable
set ambiwidth=double
set tw=0
set completeopt-=preview
set hlsearch
" set timeout timeoutlen=500 ttimeoutlen=50

" undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=4000

" 独自のキーバインディング

"" .vimrc編集
nnoremap <C-S> :suspend<CR>
nnoremap <silent> <Leader>v :<C-u>vs ~/.vimrc<CR>
nnoremap <silent> <Leader>s :so ~/.vimrc<CR>:echo 'source ~/.vimrc'<CR>
nnoremap <silent> <LEFT>  :bn<CR>
nnoremap <silent> <RIGHT> :bp<CR>
nnoremap <silent> <C-N>  :bn<CR>
nnoremap <silent> <C-P> :bp<CR>
nnoremap <silent> <Leader>e :Errors<CR>
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
nnoremap gV :vertical wincmd f<CR>
nnoremap ga ggVG<CR>
if has('nvim')
  nmap <BS> <C-W>h
endif

"" 検索結果を中心に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

set imdisable

augroup MyAutocmd
  autocmd!

  " ウィンドウを分割して開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

  autocmd BufReadPost,BufNewFile *.json,.jshintrc,.eslintrc setlocal filetype=json
  autocmd BufReadPost,BufNewFile .eslintrc setlocal filetype=yaml
  autocmd BufReadPost,BufNewFile *.jade setlocal filetype=jade
  autocmd BufReadPost,BufNewFile *.js setlocal filetype=javascript
  autocmd BufReadPost,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
  autocmd BufReadPost,BufNewFile hosts,hosts.????* autocmd BufWritePre <buffer> :%s/\s\+$//e
  autocmd BufReadPost,BufNewFile *.coffee setlocal filetype=coffee
  autocmd Filetype crontab setlocal nobackup nowritebackup
  autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
  autocmd FileType php setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html,htm,yaml,yml setlocal sw=2 ts=2 sts=2 et iskeyword+=/,-
  autocmd FileType zsh setlocal sw=2 ts=2 sts=2 et iskeyword+=/,-
  autocmd FileType css,jade setlocal sw=2 ts=2 sts=2 et iskeyword+=_,#,-
  autocmd FileType vim setlocal sw=2 ts=2 sts=2 et |
        \ let g:vim_indent_cont = 0
  autocmd FileType go,neosnippet setlocal noet noci nopi
  autocmd FileType javascript,coffee,vim,zsh,json,javascript.jsx autocmd BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType go nnoremap <buffer> <Leader>t :vs %:s#\v\.go$#_test.go#<CR>
  autocmd FileType javascript
        \ setlocal sw=2 ts=2 sts=2 et |
        \ nnoremap <buffer> <Leader>t :vs %:s#\v^[^/]+#test#<CR> |
""        \ nnoremap <buffer> <Leader>f :%!eslint --fix --stdin<CR> |
        \ nnoremap <Leader>m :QuickRun javascript/mocha<CR>

  " color
  syntax enable
  set t_Co=256
  set background=dark
  execute 'colorscheme' colorscheme
  execute 'autocmd GUIEnter * colorscheme' colorscheme
augroup END

