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
      \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
    \ 'javascript' : 1,
    \ }

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default'    : '',
    \ 'javascript' : '~/github/vim-node/dict/node.dict'
    \ }

NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
call unite#custom_source('file_rec', 'ignore_pattern', 
    \ (unite#sources#file_rec#define()[0]['ignore_pattern']) . '\|node_modules')
let g:unite_cursor_line_highlight = 'Error'
let g:unite_abbr_highlight = 'StatusLine'

" prefix key
nnoremap [Unite] <Nop>
nmap <Space> [Unite]
imap <C-c> <Plug>(unite_exit)
nmap <C-c> <Plug>(unite_exit)

" buffers
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
" files
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" registers 
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
" history
nnoremap <silent> [Unite]h :<C-u>Unite file_mru<CR>
" project
nnoremap <silent> [Unite]p :<C-u>Unite file_rec<CR>
nnoremap <silent> [Unite]<Space> :<C-u>Unite buffer file file_mru<CR>
" grep
nnoremap <silent> [Unite]g :<C-u>Unite grep -winheight=10 -no-quit<CR>
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

NeoBundle 'tsukkee/unite-tag'
nnoremap <silent> [Unite]t :<C-u>Unite tag<CR>

NeoBundle 'ujihisa/unite-colorscheme'

NeoBundleLazy 'ZenCoding.vim', {'autoload' : { 'filetypes' : ['html', 'htm'] }}
let g:user_zen_expandabbr_key = '<c-e>'

NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'Lokaltog/vim-powerline'

NeoBundle 'Syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_json_checker='jsonlint'
let g:syntastic_javascript_checker='jshint'

NeoBundle 'quickrun.vim'
let g:quickrun_config = {
  \ '_': {
  \     'runner': 'vimproc'
  \     },
  \ 'markdown': {
  \     'outputter': 'browser'
  \     },
  \ 'javascript': {
  \     'command': 'node',
  \     'tempfile': '{tempname()}.js'
  \     }
  \ }

"NeoBundle 'open-browser.vim'
"NeoBundle 'Markdown'
NeoBundleLazy 'digitaltoad/vim-jade', {'autoload' : { 'filetypes' : ['jade'] }}
NeoBundle 'thinca/vim-ft-svn_diff'

NeoBundle 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

" --------------------------------------------------------------------------------------
NeoBundle 'Tabular'
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

"NeoBundleLazy 'heavenshell/vim-jsdoc'       , {'autoload' : { 'filetypes' : ['javascript'] }}
"map <silent> <C-T> :JsDoc<CR>
"map <buffer> <C-l> <C-l>

NeoBundleLazy 'pangloss/vim-javascript'     , {'autoload' : { 'filetypes' : ['javascript'] }}
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload' : { 'filetypes' : ['javascript'] }}
NeoBundleLazy 'teramako/jscomplete-vim'     , {'autoload' : { 'filetypes' : ['javascript'] }}
"NeoBundleLazy 'marijnh/tern_for_vim', {
"  \   'autoload' : {
"  \     'filetypes' : ['javascript']
"  \   },
"  \   'build': {
"  \     'others': 'npm install'
"  \   }
"  \ }
"let g:tern_show_argument_hints='on_hold'

filetype plugin indent on
NeoBundleCheck

set nrformats= "<C-A>で8進数の計算をさせない
set clipboard+=unnamed
set noswapfile
set backupdir=$HOME/backup
set incsearch
set ignorecase | set smartcase
set ts=4 | set sw=4 | set sts=0 | set sr | set et | set ai
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
set fu
set ambiwidth=double

" undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=4000

" 独自のキーバインディング

"" .vimrc編集
nnoremap <C-S> :suspend<CR>
nnoremap <C-J> <C-M>
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>so :so $MYVIMRC<CR>
nnoremap <silent> <LEFT>  :bn<CR>
nnoremap <silent> <RIGHT> :bp<CR>
map <Space>jj !python -m json.tool<CR>
nnoremap <silent>\t :vs %:p:s#/s/#/test/#<CR>
nnoremap <silent>\e :Errors<CR>
nnoremap \m :!mocha %<CR>

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
    "let $PYTHON_DLL='/usr/local//Cellar/python/2.7.4/Frameworks/Python.framework/Versions/2.7/Python'
endif

" color
syntax on
set t_Co=256
set background=dark
let scheme = 'Tomorrow-night-bright'
execute 'colorscheme' scheme

augroup MyDev
    autocmd!

    " ウィンドウを分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

    autocmd BufRead,BufNewFile *.json set filetype=json
    autocmd BufRead,BufNewFile *.jade set filetype=jade
    autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

    autocmd FileType html,htm set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=/
    autocmd FileType cs set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=,_,#
    autocmd FileType snippet set noet
    autocmd FileType jade set noet | set iskeyword+=-,_,#
    autocmd FileType javascript set sw=4 | set ts=4 | set sts=4 | set et
    autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    autocmd FileType javascript :setl omnifunc=jscomplete#CompleteJS

    " Vimで存在しないフォルダを指定してファイル保存した時に自動で作成する。
    function! s:auto_mkdir(dir, force)  " {{{
        if !isdirectory(a:dir) && (a:force ||
            \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction  " }}}

    execute 'autocmd GUIEnter * colorscheme' scheme
augroup END

