if has('gui_macvim')
    set showtabline=2
    set antialias
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
    set guioptions+=a
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set lines=44
    set columns=100
    set fuoptions=maxvert,maxhorz

    function! ToggleFullScreen()
        if &fullscreen
            set nofu
        else
            set fu
        endif
    endfunction

    nnoremap <silent> <D-ENTER> :call ToggleFullScreen()<CR>
    nnoremap <silent> <C-z> :silent !open -a iTerm<CR>

    au GUIEnter * set nofullscreen
endif

