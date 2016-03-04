if &compatible
  set nocompatible
endif

" dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)

" プラグインリストを収めた TOML ファイル
let s:toml      = '~/.vim/rc/dein.toml'
let s:lazy_toml = '~/.vim/rc/deinlazy.toml'

" TOML を読み込み、キャッシュしておく
if dein#load_cache([expand('<sfile>'), s:toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
  scriptencoding utf-8
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
endif

" prefix key
let g:mapleader = '\'
let g:maplocalleader = ','

let colorscheme = 'jellybeans'

if dein#tap('neocomplete.vim') && has('lua') "{{{
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ }
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
endif "}}}

if dein#tap('neosnippet.vim') "{{{
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : "\<TAB>"
  let g:neosnippet#snippets_directory = '~/snippets'
  let g:neosnippet#disable_runtime_snippets = {
        \ 'javascript' : 1,
        \ }
endif "}}}

if dein#tap('unite.vim') "{{{
  let g:unite_enable_start_insert = 1
  let g:unite_options_auto_highlight = 1
  let g:unite_source_rec_max_cache_files=20000
  let g:unite_source_rec_min_cache_files=100

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
endif "}}}

if dein#tap('syntastic') "{{{
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_loc_list=2
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_css_checkers=['csslint']
  let g:syntastic_json_checkers=['jsonlint']
  let g:syntastic_javascript_checkers=['eslint']
  let g:syntastic_html_tidy_ignore_errors=[' proprietary attribute "ng-']
  let g:syntastic_go_checkers = ['go', 'golint', 'govet']
endif "}}}

if dein#tap('vim-quickrun') "{{{
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
endif "}}}

if dein#tap('eregex.vim') "{{{
  nnoremap / :M/
  nnoremap ? :M?
  nnoremap ,/ /
  nnoremap ,? ?
endif "}}}

if dein#tap('vim-go') "{{{
  let g:go_disable_autoinstall = 0
  let g:go_fmt_autosave = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_fail_silently = 1 " use syntasitic to check errors
  let g:go_play_open_browser = 0
  let g:go_snippet_engine = 'neosnippet'

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
endif "}}}

if dein#tap('javascript-libraries-syntax.vim') "{{{
  let g:used_javascript_libs = 'underscore,react'
endif "}}}

if dein#tap('vim-jsdoc') "{{{
  let g:jsdoc_default_mapping=0
  nnoremap <silent> <C-J> :JsDoc<CR>
  nnoremap <silent> <C-Q> :JsDoc<CR>
endif "}}}

if dein#tap('tern_for_vim') "{{{
  nnoremap <LocalLeader>tt :TernType<CR>
  nnoremap <LocalLeader>td :TernDef<CR>
  nnoremap <LocalLeader>tpd :TernDefPreview<CR>
  nnoremap <LocalLeader>tsd :TernDefSplit<CR>
  nnoremap <LocalLeader>ttd :TernDefTab<CR>
  nnoremap <LocalLeader>tr :TernRefs<CR>:lclose<CR>:Unite -no-quit -winheight=10 location_list<CR>
  nnoremap <LocalLeader>tR :TernRename<CR>
  nnoremap <LocalLeader>j :TernDef<CR>f'gf
  let g:tern_show_argument_hints='on_hold'
endif "}}}

if dein#tap('vim-airline') "{{{
  let g:airline_powerline_fonts=1
  set laststatus=2
  let g:airline_theme=colorscheme
endif "}}}

" filetype plugin indent on

set nrformats= "<C-A>で8進数の計算をさせない
set clipboard+=unnamed
set noswapfile
set backupdir=$HOME/.vim/backup
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
  autocmd filetype crontab setlocal nobackup nowritebackup
  autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html,htm setlocal sw=2 ts=2 sts=2 et iskeyword+=/
  autocmd FileType css,jade setlocal sw=2 ts=2 sts=2 et iskeyword+=_,#
  autocmd FileType vim setlocal sw=2 ts=2 sts=2 et
  autocmd FileType go,neosnippet setlocal noet noci nopi
  autocmd FileType javascript,coffee,vim,zsh,json,yaml,javascript.jsx autocmd BufWritePre <buffer> :%s/\s\+$//e
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

