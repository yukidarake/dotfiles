set nocompatible
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc()

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \   'cygwin' : 'make -f make_cygwin.mak',
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \ }}

NeoBundleLazy 'Shougo/neocomplete', {
      \ 'depends' : 'Shougo/context_filetype.vim',
      \ 'vim_version' : '7.3.885',
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'avascript' : '~/github/vim-node/dict/node.dict'
      \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \     'insert' : 1,
      \ }}
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets,~/github/dotfiles/snippets'
let g:neosnippet#disable_runtime_snippets = {
      \ 'javascript' : 1,
      \ }

NeoBundle 'Shougo/unite.vim', {
      \ 'autoload': {
      \   'commands' : [
      \     'Unite',
      \     'UniteWithBufferDir',
      \     'UniteWithCursorWord',
      \     'UniteWithWithInput',
      \   ],
      \ }}

NeoBundle 'Shougo/neomru.vim', {
      \ 'autoload': {
      \   'unite_sources': [
      \     'file_mru', 'directory_mru', 'neomru/file', 'neomru/directory'
      \   ],
      \ }}
let g:unite_enable_start_insert=1
"let s:file_rec_ignore_pattern = (unite#sources#rec#define()[0]['ignore_pattern']) . '\|node_modules'
"call unite#custom#source('file_rec', 'ignore_pattern', s:file_rec_ignore_pattern)
"call unite#custom#source('file_rec/async', 'ignore_pattern', s:file_rec_ignore_pattern)
let g:unite_cursor_line_highlight = 'Error'
let g:unite_abbr_highlight = 'StatusLine'
let g:unite_source_rec_max_cache_files=10000
let g:unite_source_rec_min_cache_files=50
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('line', 'matchers', 'matcher_regexp')

" prefix key
let mapleader = '\'
let maplocalleader = ','
nnoremap [Unite] <Nop>
nmap <Space> [Unite]
imap <C-c> <Plug>(unite_exit)
nmap <C-c> <Plug>(unite_exit)

nnoremap <silent> [Unite]b :<C-u>Unite buffer -quick-match<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Unite]h :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]p :<C-u>Unite file_rec/async<CR>
nnoremap <silent> [Unite]<Space> :<C-u>UniteResume<CR>
nnoremap <silent> [Unite]g :<C-u>Unite -no-quit -winheight=10 grep:<CR>
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-S --nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" " 選択した文字列をunite-grep
" " https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-i:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

nnoremap <silent> [Unite]l :<C-u>Unite line<CR>
nnoremap <silent> [Unite]j :<C-u>Unite jump<CR>

NeoBundleLazy 'Shougo/unite-outline', {
      \ 'autoload': {
      \   'unite_sources' : [
      \     'outline',
      \   ],
      \ }}
nnoremap <silent> [Unite]o :<C-u>Unite -winheight=15 outline<CR>

NeoBundleLazy 'thinca/vim-unite-history', {
      \ 'autoload': {
      \   'unite_sources' : [
      \     'history/command',
      \     'history/search',
      \     'history/yank',
      \   ],
      \ }}
nnoremap <silent> [Unite]c :<C-u>Unite history/command<CR>
nnoremap <silent> [Unite]s :<C-u>Unite history/search<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>

NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \ 'autoload': {
      \   'unite_sources' : [
      \     'location_list',
      \   ],
      \ }}
nnoremap <silent> [Unite]q :<C-u>Unite -no-quit -winheight=10 location_list<CR>

" NeoBundleLazy 'tsukkee/unite-tag', {
"       \ 'autoload' : {
"       \   'filetypes' : ['javascript']
"       \ }}
" noremap <silent> <C-]> :<C-u>Unite -immediately tag:<C-r>=expand('<cword>')<CR><CR>

NeoBundleLazy 'mattn/emmet-vim.git', {
      \ 'autoload' : {
      \   'filetypes' : ['html', 'htm']
      \ }}
"let g:user_emmet_leader_key='<C-E>'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
NeoBundle 'thinca/vim-visualstar'

NeoBundle 'bling/vim-airline'
let g:airline_theme='simple'
let g:airline_powerline_fonts=1

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_javascript_checkers=[
      \ 'jshint',
      \ 'jscs',
      \ ]
let g:syntastic_html_tidy_ignore_errors=[' proprietary attribute "ng-']
let g:syntastic_go_checkers = ['go', 'golint', 'govet']

NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'commands' : 'QuickRun',
      \ 'mappings' : [
      \   ['nxo', '<Plug>(quickrun)']],
      \ }
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks('vim-quickrun')
function! s:hooks.on_source(bundle)
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
endfunction
unlet s:hooks

NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload' : {
      \   'functions' : 'OpenBrowser',
      \   'commands'  : ['OpenBrowser', 'OpenBrowserSearch'],
      \   'mappings'  : '<Plug>(openbrowser-smart-search)',
      \   'filetypes' : ['markdown']
      \ }}
NeoBundleLazy 'tpope/vim-markdown', {
      \ 'autoload' : {
      \   'filetypes' : ['markdown']
      \ }}
NeoBundleLazy 'kannokanno/previm', {
      \ 'autoload' : {
      \   'filetypes' : ['markdown']
      \ }}
NeoBundleLazy 'digitaltoad/vim-jade', {
      \ 'autoload' : {
      \   'filetypes' : ['jade']
      \ }}
NeoBundle 'thinca/vim-ft-svn_diff'

NeoBundle 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

NeoBundleLazy 'fatih/vim-go', {
      \ 'autoload' : {
      \   'filetypes' : ['go']
      \ }}
let s:hooks = neobundle#get_hooks('tern_for_vim')
function! s:hooks.on_source(bundle)
  let g:go_bin_path = expand("~/.go/bin")
  let g:go_disable_autoinstall = 1
  let g:go_fmt_autosave = 0
  let g:go_fmt_command = "gofmt"
  let g:go_fmt_fail_silently = 1 " use syntasitic to check errors
  let g:go_play_open_browser = 0
  let g:go_snippet_engine = 'neosnippet'
  let g:gofmt_command = 'goimports'
  let g:neosnippet#snippets_directory .= ',~/.vim/bundle/vim-go/gosnippets/snippets/go.snippets'

  augroup MyGoAutocmd
    autocmd!
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
    autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>gb <Plug>(go-build)
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
    autocmd FileType go nmap gd <Plug>(go-def)
    autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
    autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
    autocmd FileType go nmap <Leader>gl :GoLint<CR>
    autocmd BufWritePre *.go Fmt
  augroup END
endfunction
unlet s:hooks

NeoBundleLazy 'Tabular', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

NeoBundle 'mopp/autodirmake.vim'

NeoBundleLazy 'pangloss/vim-javascript', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript'
      \ }}

NeoBundleLazy 'jelera/vim-javascript-syntax', {
      \ 'autoload' : {
      \    'filetypes' : 'javascript'
      \ }}

NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
      \ 'autoload' : {
      \    'filetypes' : 'javascript'
      \ }}

NeoBundleLazy 'heavenshell/vim-jsdoc', {
      \ 'autoload' : {
      \    'filetypes' : 'javascript'
      \ }}
let s:hooks = neobundle#get_hooks('vim-jsdoc')
function! s:hooks.on_source(bundle)
  let g:jsdoc_default_mapping=0
endfunction
unlet s:hooks


NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'autoload' : {
      \   'functions' : ['tern#Complete', 'tern#Enable'],
      \   'filetypes' : 'javascript'
      \ },
      \ 'commands' : ['TernDef', 'TernDoc', 'TernType', 'TernRefs', 'TernRename'],
      \ 'build': {
      \   'others': 'npm install'
      \ }}
let s:hooks = neobundle#get_hooks('tern_for_vim')
function! s:hooks.on_source(bundle)
  nnoremap <LocalLeader>tt :TernType<CR>
  nnoremap <LocalLeader>td :TernDef<CR>
  nnoremap <LocalLeader>tpd :TernDefPreview<CR>
  nnoremap <LocalLeader>tsd :TernDefSplit<CR>
  nnoremap <LocalLeader>ttd :TernDefTab<CR>
  nnoremap <LocalLeader>tr :TernRefs<CR>:lclose<CR>:Unite -no-quit -winheight=10 location_list<CR>
  nnoremap <LocalLeader>tR :TernRename<CR>
  nnoremap <LocalLeader>j :TernDef<CR>f'gf
  let g:tern_show_argument_hints='on_hold'
endfunction
unlet s:hooks

NeoBundle 'moll/vim-node'

NeoBundle 'tpope/vim-commentary'

filetype plugin indent on
NeoBundleCheck

set nrformats= "<C-A>で8進数の計算をさせない
set clipboard+=unnamed
set noswapfile
set backupdir=$HOME/backup
set incsearch
set ignorecase smartcase
set ts=2 sw=2 sts=0 sr et ai
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

" undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=4000

" 独自のキーバインディング

"" .vimrc編集
nnoremap <C-S> :suspend<CR>
nnoremap <C-J> <C-M>
nnoremap <silent> <Leader>v :<C-u>vs $MYVIMRC<CR>
nnoremap <silent> <Leader>s :so $MYVIMRC<CR>
nnoremap <silent> <LEFT>  :bn<CR>
nnoremap <silent> <RIGHT> :bp<CR>
nnoremap <silent> <C-N>  :bn<CR>
nnoremap <silent> <C-P> :bp<CR>
nnoremap <silent> <Leader>e :Errors<CR>
nnoremap gv :vertical wincmd f<CR>
nnoremap ga ggVG<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

"" 検索結果を中心に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 「日本語入力固定モード」切替キー
"inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
" 「日本語入力固定モード」の動作モード
"let IM_CtrlMode = 4
set noimdisable

if has('kaoriya')
  let $PYTHON_DLL='/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Python'
endif

augroup MyAutocmd
  autocmd!

  " ウィンドウを分割して開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

  autocmd BufReadPost,BufNewFile *.json,.jshintrc setl filetype=json
  autocmd BufReadPost,BufNewFile *.jade setl filetype=jade
  autocmd BufReadPost,BufNewFile *.js setl filetype=javascript
  autocmd BufReadPost,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} setl filetype=markdown
  autocmd BufReadPost,BufNewFile hosts,hosts.????* autocmd BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType html,htm setl sw=2 ts=2 sts=2 et iskeyword+=/
  autocmd FileType css,jade setl sw=2 ts=2 sts=2 et iskeyword+=_,#
  autocmd FileType vim setl sw=2 ts=2 sts=2 et
  autocmd FileType go,neosnippet setl noet noci nopi
  autocmd FileType javascript,vim autocmd BufWritePre <buffer> :%s/\s\+$//e
  autocmd FileType javascript
        \ setl sw=4 ts=4 sts=4 et |
        \ nnoremap <buffer> <Leader>t :vs %:s#\v^[^/]+#test#<CR> |
        \ nnoremap <Leader>m :QuickRun javascript/mocha<CR>

  " color
  syntax on
  set t_Co=256
  set background=dark
  let scheme = 'jellybeans'
  "let scheme = 'hybrid'
  "let scheme = 'Tomorrow-night-bright'
  execute 'colorscheme' scheme
  execute 'autocmd GUIEnter * colorscheme' scheme

  if !exists('g:neocomplete#sources#omni#functions')
    let g:neocomplete#sources#omni#functions = {}
  endif

  " 'tern#Complete',
  let g:neocomplete#sources#omni#functions.javascript = [
        \ 'tern#Complete',
        \ 'javascriptcomplete#CompleteJS',
        \ ]

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

  autocmd User Node
        \ if &filetype == "javascript" |
        \   nnoremap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
        \   nnoremap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
        \ endif
augroup END

