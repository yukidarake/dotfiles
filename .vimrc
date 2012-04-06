set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" --------------------------------------------------------------------------------------
Bundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
imap <TAB> <Plug>(neocomplcache_snippets_expand)
smap <TAB> <Plug>(neocomplcache_snippets_expand)
let g:neocomplcache_snippets_dir = $HOME . '/snippets'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'javascript' : $HOME.'/github/vim-node/dict/node.dict'
    \ }

" --------------------------------------------------------------------------------------
Bundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_file_rec_ignore_pattern=
 \'\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|ba\?k\|sw[po]\|tmp\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)\|node_modules'
" 入力モードで開始する
let g:unite_enable_start_insert=1

" prefix key
nnoremap [Unite] <Nop>
nmap <Space> [Unite]

" バッファ一覧
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [Unite]h :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> [Unite]u :<C-u>Unite buffer file_mru<CR>
" プロジェクト
nnoremap <silent> [Unite]p :<C-u>call <SID>unite_project('-start-insert')<CR>
function! s:unite_project(...)
    let opts = (a:0 ? join(a:000, ' ') : '')
    let dir = unite#util#path2project_directory(expand('%'))
    execute 'Unite' opts 'file_rec:' . dir
endfunction

augroup MyUnite
    autocmd!
    " ウィンドウを分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
augroup END

Bundle 't9md/vim-unite-ack'
let g:unite_source_ack_command='ack --color'
nnoremap <silent> [Unite]a  :<C-u>exe "Unite -buffer-name=ack ack::" .  escape(expand('<cword>'),' :\')<CR>
vnoremap <silent> [Unite]a  :<C-u>exe "Unite -buffer-name=ack ack::" .  <SID>visual_unite_arg()<CR>
nnoremap <silent> [Unite]A  :<C-u>UniteResume ack<CR>


" --------------------------------------------------------------------------------------
Bundle 'Shougo/vimproc'

" --------------------------------------------------------------------------------------
" Bundle 'ZenCoding.vim'
" let g:user_zen_expandabbr_key = '<c-e>'

" --------------------------------------------------------------------------------------
Bundle 'surround.vim'
Bundle 'repeat.vim'

" --------------------------------------------------------------------------------------
Bundle 'molokai'

" --------------------------------------------------------------------------------------
Bundle 'jamescarr/snipmate-nodejs'

" --------------------------------------------------------------------------------------
Bundle 'pangloss/vim-javascript'

" --------------------------------------------------------------------------------------
Bundle 'JavaScript-syntax'

" --------------------------------------------------------------------------------------
Bundle 'ack.vim'

" --------------------------------------------------------------------------------------
Bundle 'Lokaltog/vim-powerline'

" --------------------------------------------------------------------------------------
Bundle 'Syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"
" --------------------------------------------------------------------------------------
"Bundle 'majutsushi/tagbar'
"nnoremap <F8> :TagbarToggle<CR>

" --------------------------------------------------------------------------------------
Bundle 'quickrun.vim'
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser'
      \ }
let $JS_CMD='node'

" --------------------------------------------------------------------------------------
Bundle 'open-browser.vim'

" --------------------------------------------------------------------------------------
Bundle 'Markdown'

" --------------------------------------------------------------------------------------
Bundle 'https://github.com/thinca/vim-ft-svn_diff.git'

" --------------------------------------------------------------------------------------
Bundle 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

" /Vundle
filetype plugin indent on

" color
syntax on
set background=dark
set t_Co=256
let scheme = 'molokai'
augroup guicolorscheme
autocmd!
    execute 'autocmd GUIEnter * colorscheme' scheme
augroup END
execute 'colorscheme' scheme

set nrformats= "<C-A>で8進数の計算をさせない
set clipboard+=unnamed
set noswapfile
"set directory=$HOME/swap
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
"set showtabline=2 "常にタブ表示
set title
set wildmenu " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmode=list:longest " コマンドライン補間をシェルっぽく
set cursorline " カーソル行表示
set hidden

" grep
"set grepprg=grep\ -nHPR\ --exclude='*.svn*'
set grepprg=ack\ -a\ --nocolor
nmap ;q :Unite qf<CR>
nmap ;/ :grep  \| Unite qf<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

set fdm=manual
set nofoldenable

" 独自のキーバインディング

"" .vimrc編集
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>

nnoremap <C-J> <C-M>

nnoremap <silent> <Space>er  :Errors<CR>


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

" <C-S>でsave
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

augroup MyDev
    autocmd!
    autocmd FileType html,htm set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=/
    autocmd FileType css set noet | set iskeyword+=-,_,#
    autocmd FileType javascript set sw=4 | set ts=4 | set sts=4 | set et
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd BufWritePre * %s/\s\+$//e
augroup END

