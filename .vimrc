set nocompatible
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
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

"NeoBundle 'Shougo/neocomplcache'
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_auto_completion_start_length = 2
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_underbar_completion = 1
"" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default'    : '',
"    \ 'javascript' : '~/github/vim-node/dict/node.dict'
"    \ }

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

NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let s:file_rec_ignore_pattern = (unite#sources#rec#define()[0]['ignore_pattern']) . '\|node_modules'
call unite#custom#source('file_rec', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('file_rec/async', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('grep', 'ignore_pattern', s:file_rec_ignore_pattern)
let g:unite_cursor_line_highlight = 'Error'
let g:unite_abbr_highlight = 'StatusLine'

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
nnoremap <silent> [Unite]g :<C-u>Unite grep::-i -winheight=10 -no-quit<C-F><S-F>:,i
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" " 選択した文字列をunite-grep
" " https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-i:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" line
nnoremap <silent> [Unite]l :<C-u>Unite line<CR>

NeoBundle 'Shougo/unite-outline'
nnoremap <silent> [Unite]o :<C-u>Unite outline -winheight=15<CR>

NeoBundle 'thinca/vim-unite-history'
nnoremap <silent> [Unite]c :<C-u>Unite history/command<CR>
nnoremap <silent> [Unite]s :<C-u>Unite history/search<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>

NeoBundle 'osyo-manga/unite-quickfix'
nnoremap <silent> [Unite]q :<C-u>Unite -no-quit -winheight=10 location_list<CR>

NeoBundle 'hrsh7th/vim-versions'
nnoremap <silent> [Unite]v :<C-u>UniteVersions

NeoBundleLazy 'ZenCoding.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html', 'htm']
      \ }}
let g:user_zen_expandabbr_key = '<c-e>'

NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
NeoBundle 'thinca/vim-visualstar'

NeoBundle 'bling/vim-airline'
let g:airline_theme='simple'
let g:airline_powerline_fonts=1

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'Syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_json_checker='jsonlint'
let g:syntastic_javascript_checker='jshint'

NeoBundle 'quickrun.vim'
let g:quickrun_config = {
      \ '_': {
      \   'runner': 'vimproc'
      \ },
      \ 'markdown': {
      \   'outputter': 'browser'
      \ },
      \ 'javascript': {
      \   'command': 'node',
      \   'tempfile': '{tempname()}.js'
      \ }}

NeoBundleLazy "tyru/open-browser.vim", {
      \ 'autoload' : {
      \   'functions' : "OpenBrowser",
      \   'commands'  : ["OpenBrowser", "OpenBrowserSearch"],
      \   'mappings'  : "<Plug>(openbrowser-smart-search)",
      \   'filetypes' : ['markdown']
      \ }},
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

NeoBundleLazy 'pangloss/vim-javascript', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript'
      \ }}
"NeoBundleLazy 'jelera/vim-javascript-syntax', {
"    \ 'autoload' : {
"    \    filetypes' : 'javascript'
"    \ }}

NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript',
      \ },
      \ 'build': {
      \   'others': 'npm install'
      \ }}
nnoremap <LocalLeader>tt :TernType<CR>
nnoremap <LocalLeader>td :TernDef<CR>
nnoremap <LocalLeader>tpd :TernDefPreview<CR>
nnoremap <LocalLeader>tsd :TernDefSplit<CR>
nnoremap <LocalLeader>ttd :TernDefTab<CR>
nnoremap <LocalLeader>tr :TernRefs:lclose<CR>:Unite -no-quit -winheight=10 location_list<CR><CR>
nnoremap <LocalLeader>tR :TernRename<CR>'
let g:tern_show_argument_hints='on_hold'

NeoBundle 'moll/vim-node'

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
nnoremap <silent> <Leader>ev :<C-u>vs $MYVIMRC<CR>
nnoremap <silent> <Leader>so :so $MYVIMRC<CR>
nnoremap <silent> <LEFT>  :bn<CR>
nnoremap <silent> <RIGHT> :bp<CR>
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

"ステータス表示系
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

" 信頼性を犠牲にして高速化
if has('unix')
  set nofsync
  set swapsync=
endif

if has('kaoriya')
  let $PYTHON_DLL='/usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Python'
endif

augroup MyDev
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

  autocmd FileType html,htm setl sw=2 ts=2 sts=2 et iskeyword+=/
  autocmd FileType cs setl sw=2 ts=2 sts=2 et iskeyword+=,_,#
  autocmd FileType vim setl sw=2 ts=2 sts=2 et
  autocmd FileType snippet setl noet
  autocmd FileType jade setl noet iskeyword+=-,_,#
  autocmd FileType javascript,vim autocmd BufWritePre <buffer> :%s/\s\+$//e
  autocmd FileType javascript
        \ setl sw=4 ts=4 sts=4 et |
        \ nnoremap <buffer> <Leader>t :vs %:s#\v^[^/]+#test#<CR> |
        \ nnoremap <Leader>m :!mocha %<CR>

  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)


  " Vimで存在しないフォルダを指定してファイル保存した時に自動で作成する。
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}

  " color
  syntax on
  set t_Co=256
  set background=dark
  let scheme = 'jellybeans'
  "let scheme = 'hybrid'
  "let scheme = 'Tomorrow-night-bright'
  execute 'colorscheme' scheme
  execute 'autocmd GUIEnter * colorscheme' scheme

  if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
  endif

  let g:neocomplcache_omni_functions.javascript = [
      \ 'tern#Complete',
      \ 'javascriptcomplete#CompleteJS'
      \ ]

  autocmd User Node
    \ if &filetype == "javascript" |
    \   nnoremap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
    \   nnoremap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
    \ endif
augroup END

