set nocompatible

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" --------------------------------------------------------------------------------------
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
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
let g:neocomplcache_omni_functions = {
    \ 'javascript' : 'jscomplete#CompleteJS',
    \ 'python'     : 'pythoncomplete#Complete',
    \ 'ruby'       : 'rubycomplete#Complete',
    \ }

" --------------------------------------------------------------------------------------
Bundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_file_rec_ignore_pattern=
 \'\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|ba\?k\|sw[po]\|tmp\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)\|node_modules'
let g:unite_cursor_line_highlight = 'Error'
let g:unite_abbr_highlight = 'StatusLine'

" prefix key
nnoremap [Unite] <Nop>
nmap <Space> [Unite]

" buffers
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
" files
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" registers 
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
" history
nnoremap <silent> [Unite]h :<C-u>Unite file_mru<CR>
" project
nnoremap <silent> [Unite]p :<C-u>Unite file_rec/async<CR>
nnoremap <silent> [Unite]<Space> :<C-u>Unite file_rec/async:
" grep
nnoremap <silent> [Unite]g :<C-u>Unite grep<CR>
" line
nnoremap <silent> [Unite]l :<C-u>Unite line<CR>

" For ack.
if executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    let g:unite_source_grep_recursive_opt = ''
endif

augroup MyUnite
    autocmd!
    " ウィンドウを分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
augroup END

Bundle 'h1mesuke/unite-outline'
nnoremap <silent> [Unite]o :<C-u>Unite outline<CR>

Bundle 'thinca/vim-unite-history'
nnoremap <silent> [Unite]c :<C-u>Unite history/command<CR>
nnoremap <silent> [Unite]s :<C-u>Unite history/search<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>

Bundle 'tsukkee/unite-tag'
nnoremap <silent> [Unite]t :<C-u>Unite tag<CR>

" --------------------------------------------------------------------------------------
Bundle 'Shougo/vimproc'

" --------------------------------------------------------------------------------------
" Bundle 'ZenCoding.vim'
" let g:user_zen_expandabbr_key = '<c-e>'

" --------------------------------------------------------------------------------------
Bundle 'surround.vim'
Bundle 'repeat.vim'

" --------------------------------------------------------------------------------------
" Bundle 'yukidarake/vim-monokai'
Bundle 'altercation/vim-colors-solarized'

" --------------------------------------------------------------------------------------
Bundle 'pangloss/vim-javascript'

" --------------------------------------------------------------------------------------
Bundle 'jelera/vim-javascript-syntax'

" --------------------------------------------------------------------------------------
Bundle 'teramako/jscomplete-vim'

" --------------------------------------------------------------------------------------
Bundle 'Lokaltog/vim-powerline'

" --------------------------------------------------------------------------------------
Bundle 'Syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_json_checker='jsonlint'
let g:syntastic_javascript_checker='jshint'

" --------------------------------------------------------------------------------------
"Bundle 'majutsushi/tagbar'
"noremap <F8> :TagbarToggle<CR>

" --------------------------------------------------------------------------------------
Bundle 'quickrun.vim'
let g:quickrun_config = {
  \ 'markdown': {
  \     'outputter': 'browser'
  \     },
  \ 'javascript': {
  \     'command': 'node',
  \     'tempfile': '{tempname()}.js'
  \     }
  \ }

" --------------------------------------------------------------------------------------
"Bundle 'open-browser.vim'

" --------------------------------------------------------------------------------------
"Bundle 'Markdown'

" --------------------------------------------------------------------------------------
Bundle 'digitaltoad/vim-jade'

" --------------------------------------------------------------------------------------
Bundle 'thinca/vim-ft-svn_diff'

" --------------------------------------------------------------------------------------
Bundle 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

" --------------------------------------------------------------------------------------
Bundle 'Tabular'
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

" /Vundle
filetype plugin indent on

" color
syntax on
set background=dark
if &diff
    let scheme = 'darkblue'
else
    let scheme = 'solarized'
    "let g:solarized_visibility = 'high'
    "let g:solarized_contrast = 'high'
endif
augroup guicolorscheme
autocmd!
    execute 'autocmd GUIEnter * colorscheme' scheme
augroup END
execute 'colorscheme' scheme

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

" undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=4000

" 独自のキーバインディング

"" .vimrc編集
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <C-J> <C-M>
nnoremap <silent> <Space>ee :Errors<CR>
nnoremap <silent> <LEFT>  :bn<CR>
nnoremap <silent> <RIGHT> :bp<CR>
map <Space>jj !python -m json.tool<CR>
nnoremap <silent>\t :vs %:s#s/#test/#<CR>
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

augroup MyDev
    autocmd!
    autocmd FileType html,htm set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=/
    autocmd FileType cs set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=,_,#
    autocmd FileType jade set noet | set iskeyword+=-,_,#
    autocmd FileType javascript set sw=4 | set ts=4 | set sts=4 | set et
    autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd FileType snippet set noet
    autocmd TabEnter * execute 'cd .'
    autocmd BufRead,BufNewFile *.json set filetype=json 
augroup END

