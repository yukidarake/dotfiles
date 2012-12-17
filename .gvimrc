if has('gui_macvim')
    set showtabline=2
    set antialias
    set guifont=Ricty:h14
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set lines=90 
    set columns=200
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen

    function! ToggleFullScreen()
        if &fullscreen
            set nofu
        else
            set fu
        endif
    endfunction

    nnoremap <silent> <D-ENTER> :call ToggleFullScreen()<CR>
    nnoremap <silent> <C-z> :silent !open -a iTerm<CR>
endif

