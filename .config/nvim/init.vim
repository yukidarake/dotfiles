call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'jacoborus/tender.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'khaveesh/vim-fish-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

" prefix key
let g:mapleader = '\'
let g:maplocalleader = ','

set clipboard+=unnamedplus
set noswapfile
set undofile
set number
set ts=2 sw=2 sts=2 sr et ai
set termguicolors

nnoremap <C-S> :suspend<CR>
nnoremap <silent> <Leader>v :<C-u>vs ~/.config/nvim/init.vim<CR>
nnoremap <silent> <Leader>s :so ~/.config/nvim/init.vim<CR>:echo 'init.vim reloaded'<CR>
nnoremap <silent> <Leader>e :Errors<CR>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

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

let colorscheme = 'tender'
execute 'colorscheme' colorscheme
let g:lightline = { 'colorscheme': colorscheme }

if has('gui_vimr')
  nnoremap <D-RIGHT> :tabnext<CR>
  nnoremap <D-LEFT> :tabprev<CR>
endif

