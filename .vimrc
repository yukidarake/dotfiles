set enc=utf-8
set fencs=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16le,utf-16,default,latin1
set fileformats=unix,dos,mac
set shell=/bin/bash

call plug#begin()
let g:plug_threads = 6

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap [FZF] <Nop>
nmap <Space> [FZF]
nnoremap [FZF]b :Buffers<CR>
nnoremap [FZF]x :Commands<CR>
nnoremap [FZF]f :Files %:h<CR>
nnoremap [FZF]e :Files .<CR>
nnoremap [FZF]p :GitFiles .<CR>
nnoremap [FZF]k :bd<CR>
nnoremap [FZF]l :BLines<CR>
nnoremap [FZF]r :History<CR>
nnoremap [FZF]<Space> :Buffers<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap [FZF]a :Rg<CR>

Plug 'StanAngeloff/php.vim'
Plug 'jwalton512/vim-blade'

" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'stephpy/vim-php-cs-fixer'
" If php-cs-fixer is in $PATH, you don't need to define line below
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
set t_Co=256
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
let g:php_cs_fixer_php_path = "php"               " Path to PHP
" let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.

augroup PhpAutocmd
  autocmd!
  autocmd FileType php
  \ setlocal sw=4 ts=4 sts=4 et |
  \ nnoremap <silent><leader>df :call PhpCsFixerFixDirectory()<CR> |
  \ nnoremap <silent><leader>f :call PhpCsFixerFixFile()<CR>
augroup END

" function! BuildYCM(info)
"   if a:info.status == 'installed' || a:info.force
"     !./install.py --clang-completer --gocode-completer
"   endif
" endfunction
" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp'], 'do': function('BuildYCM') }
" Plug 'tell-k/vim-autopep8'
" let g:autopep8_disable_show_diff=1
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-visualstar'
Plug 'thinca/vim-quickrun'

Plug 'othree/eregex.vim'
nnoremap / :m/
nnoremap ? :m?
nnoremap ,/ /
nnoremap ,? ?

Plug 'editorconfig/editorconfig-vim'
Plug 'jacoborus/tender.vim'
let macvim_skip_colorscheme=1
Plug 'othree/yajs.vim', { 'for': ['javascript'] } " es6のハイライト
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript'] }  " stage-0 のsyntax highlight
Plug 'tpope/vim-commentary'
Plug 'cespare/vim-toml', { 'for': ['toml'] }
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
Plug 'chrisbra/vim-diff-enhanced'
Plug 'pearofducks/ansible-vim', { 'for': ['yaml'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['py'] }
Plug 'w0rp/ale'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['flake8'],
\   'dockerfile': ['hadolint'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'python': ['autopep8'],
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_typescript_prettier_use_local_config = 1

Plug 'dag/vim-fish'

let colorscheme = 'tender'

Plug 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': colorscheme }

augroup JsAutocmd
  autocmd!
  autocmd FileType javascript
  \ setlocal sw=2 ts=2 sts=2 et |
  \ nnoremap <buffer> <Leader>t :vs %:s#\v^[^/]+#test#<CR> |
  \ nmap <Leader>f <Plug>(Prettier) |
  \ nnoremap <Leader>m :QuickRun javascript/mocha<CR>
augroup END

augroup PythonAutocmd
  autocmd!
  autocmd FileType python
  \ nnoremap <buffer> <Leader>f :Autopep8<CR>
augroup END

call plug#end()

" prefix key
let g:mapleader = '\'
let g:maplocalleader = ','

set laststatus=2
set nrformats-=octal
set clipboard+=unnamed
set noswapfile
set incsearch
set ignorecase smartcase
set ts=2 sw=2 sts=2 sr et ai
set nolist
set history=10000
set number
set backspace=indent,eol,start
set ruler
set showmatch
set showmode
set virtualedit+=block " http://vim-users.jp/2010/02/hack125/
set title
set wildmenu
set wildmode=list:longest
set cursorline
set hidden
set fdm=manual
set nofoldenable
set ambiwidth=double
set tw=0
set completeopt-=preview
set hlsearch
" set timeout timeoutlen=500 ttimeoutlen=50
set backupdir=~/.vim/backup
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=4000

nnoremap <C-S> :suspend<CR>
nnoremap <silent> <Leader>v :<C-u>vs ~/.vimrc<CR>
nnoremap <silent> <Leader>s :so ~/.vimrc<CR>:echo 'source ~/.vimrc'<CR>
nnoremap <silent> <Leader>e :Errors<CR>
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
nnoremap gV :vertical wincmd f<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

if v:version >= 800
  set emoji
  set fixendofline
  set termguicolors
endif

augroup MyAutocmd
  autocmd!
  autocmd BufReadPost,BufNewFile *.json,.jshintrc,.eslintrc setlocal filetype=json
  autocmd BufReadPost,BufNewFile Supfile,.eslintrc,*.dig setlocal filetype=yaml
  autocmd BufReadPost,BufNewFile Dockerfile.* setlocal filetype=dockerfile
  autocmd BufReadPost,BufNewFile .inc setlocal filetype=php
  autocmd BufReadPost,BufNewFile *.jade setlocal filetype=jade
  autocmd BufReadPost,BufNewFile *.{js,mjs} setlocal filetype=javascript
  autocmd BufReadPost,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
  autocmd BufReadPost,BufNewFile hosts,hosts.????* autocmd BufWritePre <buffer> :%s/\s\+$//e
  autocmd BufReadPost,BufNewFile *.coffee setlocal filetype=coffee
  autocmd BufReadPost,BufNewFile *.blade.php setlocal filetype=blade
  autocmd BufReadPost,BufNewFile *.gradle setlocal filetype=groovy
  autocmd Filetype crontab setlocal nobackup nowritebackup
  autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
  autocmd FileType php setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html,htm,yaml,yml,blade setlocal sw=2 ts=2 sts=2 et iskeyword+=/,-
  autocmd FileType zsh setlocal sw=2 ts=2 sts=2 et iskeyword+=/,-
  autocmd FileType css,jade setlocal sw=2 ts=2 sts=2 et iskeyword+=_,#,-
  autocmd FileType vim setlocal sw=2 ts=2 sts=2 et |
  autocmd FileType make setlocal sw=4 ts=4 sts=4  ts=4 noet |
  \ let g:vim_indent_cont = 0
  autocmd FileType go,neosnippet setlocal noet noci nopi
  autocmd FileType javascript,vim,json,javascript,jsx,go autocmd BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType go nnoremap <buffer> <Leader>t :vs %:s#\v\.go$#_test.go#<CR>

  " color
  syntax enable


  execute 'colorscheme' colorscheme
  execute 'autocmd GUIEnter * colorscheme' colorscheme
  execute 'highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE guifg=NONE guibg=SkyBlue1'
augroup END
