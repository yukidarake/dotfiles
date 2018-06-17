if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
  scriptencoding utf-8
  set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap [FZF] <Nop>
nmap <Space> [FZF]
nnoremap <silent> [FZF]b :<C-u>Buffers<CR>
nnoremap <silent> [FZF]h :<C-u>History<CR>
nnoremap <silent> [FZF]l :<C-u>BLines<CR>
nnoremap <silent> [FZF]f :<C-u>Files %:h<CR>
nnoremap <silent> [FZF]p :<C-u>Files .<CR>
nnoremap <silent> [FZF]a :<C-u>Rg<CR>
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-visualstar'
Plug 'othree/eregex.vim'
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?
Plug 'mopp/autodirmake.vim'
Plug 'itchyny/lightline.vim'

Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save = 1

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
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
Plug 'fatih/vim-go', { 'for': ['go'] }
" let g:go_fmt_command = 'goimports'
let g:go_disable_autoinstall = 0
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1 " use syntasitic to check errors
let g:go_play_open_browser = 0
let g:go_snippet_engine = 'neosnippet'
augroup MyGoAutocmd
  autocmd!
  autocmd FileType go nmap <LocalLeader>i <Plug>(go-info)
  autocmd FileType go nmap <LocalLeader>dc <Plug>(go-doc)
  autocmd FileType go nmap <LocalLeader>dcv <Plug>(go-doc-vertical)
  " autocmd FileType go nmap <LocalLeader>r <Plug>(go-run)
  autocmd FileType go nmap <LocalLeader>b <Plug>(go-build)
  autocmd FileType go nmap <LocalLeader>t <Plug>(go-test)
  autocmd FileType go nmap <LocalLeader>c <Plug>(go-coverage)
  autocmd FileType go nmap <LocalLeader>d <Plug>(go-def)
  autocmd FileType go nmap <LocalLeader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <LocalLeader>dv <Plug>(go-def-vertical)
  autocmd FileType go nnoremap <LocalLeader>l :GoLint<CR>
  autocmd FileType go nmap <LocalLeader>f <Plug>(go-imports)
augroup END
Plug 'w0rp/ale'
Plug 'cespare/vim-toml', { 'for': ['toml'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript'] }
Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'Quramy/tsuquyomi', { 'for': ['typescript'] }
" augroup MyTSAutocmd
"   autocmd!
"   autocmd FileType typescript setlocal omnifunc=TSScompleteFunc
" augroup END
Plug 'chrisbra/vim-diff-enhanced'
Plug 'tyru/open-browser.vim'
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja'] }
Plug 'pearofducks/ansible-vim', { 'for': ['yaml'] }
Plug 'editorconfig/editorconfig-vim'

Plug 'jacoborus/tender.vim'
let colorscheme = 'tender'

call plug#end()

" prefix key
let g:mapleader = '\'
let g:maplocalleader = ','

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
  autocmd FileType javascript,coffee,vim,zsh,json,javascript,jsx,go autocmd BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType go nnoremap <buffer> <Leader>t :vs %:s#\v\.go$#_test.go#<CR>
  autocmd FileType terraform setlocal commentstring=#%s
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
  execute 'highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE'
augroup END

