if &compatible
  set nocompatible
endif

" load plugins
set runtimepath+=~/.vim/
runtime! rc/plugins.vim

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
  scriptencoding utf-8
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
endif

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

