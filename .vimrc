set nocompatible

filetype off " Vundle

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" --------------------------------------------------------------------------------------
Bundle 'neocomplcache'
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_quick_match = 1
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
Bundle 'unite.vim' 
"Bundle 'tsukkee/unite-tag'
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uh :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" プロジェクト
nnoremap <silent> ,up :<C-u>call <SID>unite_project('-start-insert')<CR>
function! s:unite_project(...)
    let opts = (a:0 ? join(a:000, ' ') : '')
    let dir = unite#util#path2project_directory(expand('%'))
    execute 'Unite' opts 'file_rec:' . dir
endfunction
" tags
"nnoremap <silent> ,ut :<C-u>Unite tag<CR>

augroup MyUnite
    autocmd!
    " ウィンドウを分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
augroup END

" --------------------------------------------------------------------------------------
" Bundle 'ZenCoding.vim'
" let g:user_zen_expandabbr_key = '<c-e>'  

" --------------------------------------------------------------------------------------
Bundle 'surround.vim'
Bundle 'repeat.vim'

" --------------------------------------------------------------------------------------
Bundle 'molokai' 

" --------------------------------------------------------------------------------------
Bundle 'serverhorror/javascript.vim'

" --------------------------------------------------------------------------------------
Bundle 'basyura/jslint.vim'
function! s:javascript_filetype_settings()
    autocmd BufLeave     <buffer> call jslint#clear()
    autocmd BufWritePost <buffer> call jslint#check()
    autocmd CursorMoved  <buffer> call jslint#message()
endfunction
augroup MyJslint
    autocmd FileType javascript call s:javascript_filetype_settings()
augroup END

" --------------------------------------------------------------------------------------
Bundle 'jamescarr/snipmate-nodejs'

" --------------------------------------------------------------------------------------
Bundle 'pangloss/vim-javascript'

" --------------------------------------------------------------------------------------
Bundle 'ack.vim'

" --------------------------------------------------------------------------------------
" Bundle 'https://github.com/joestelmach/javaScriptLint.vim.git'

" --------------------------------------------------------------------------------------
"Bundle 'Shougo/vimfiler'

" --------------------------------------------------------------------------------------
"Bundle 'majutsushi/tagbar'

" --------------------------------------------------------------------------------------
"Bundle 'juvenn/mustache'

" --------------------------------------------------------------------------------------
Bundle 'https://github.com/thinca/vim-ft-svn_diff.git'

" --------------------------------------------------------------------------------------
Bundle 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

filetype plugin indent on " Vundle

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

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

" grep
set grepprg=grep\ -nHPR\ --exclude='*.svn*'

set fdm=manual
set nofoldenable

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

augroup MyDev
    autocmd!
    autocmd FileType html,htm set sw=2 | set ts=2 | set sts=2 | set et | set iskeyword+=/ 
    autocmd FileType css set noet | set iskeyword+=-,_,#
    autocmd FileType javascript set sw=4 | set ts=4 | set sts=4 | set noet
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

