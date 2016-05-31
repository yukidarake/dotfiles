" dein configurations.
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
endif

let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

let g:dein#install_progress_type = 'title'

let s:path = expand(s:dein_dir)
if !dein#load_state(s:path)
  finish
endif

let s:toml_path = '~/.vim/rc/dein.toml'
let s:toml_lazy_path = '~/.vim/rc/deinlazy.toml'

call dein#begin(s:path, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])
call dein#load_toml(s:toml_path, {'lazy': 0})
call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
call dein#end()
call dein#save_state()

if has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif
