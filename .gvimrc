if has('gui_macvim')
  set showtabline=2
  set antialias
  set guifont=Hack:h14
  set guioptions+=a
  set guioptions-=T
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
  set lines=54
  set columns=120
  set fuoptions=maxvert,maxhorz
  set formatoptions=q
  " set imdisable
  highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE guifg=NONE guibg=SkyBlue1

  function! ToggleFullScreen()
    if &fullscreen
      set nofu
    else
      set fu
    endif
  endfunction

  nnoremap <silent> <D-ENTER> :call ToggleFullScreen()<CR>
  nnoremap <silent> <C-z> :silent !open -a iTerm<CR>
  nnoremap <D-Right> <Esc>gT
  nnoremap <D-Left> <Esc>gt

  au GUIEnter * set nofullscreen
endif
