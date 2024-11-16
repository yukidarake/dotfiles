" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $
" Quickly remove search highlights
nmap <C-l> :nohl
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent

" Maps pasteinto to Alt-p
map <A-p> :pasteinto

" https://github.com/esm7/obsidian-vimrc-support#surround-text-with-surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
" nunmap s
" vunmap S
" map s" :surround_double_quotes
" map s' :surround_single_quotes
" map s` :surround_backticks
" map sb :surround_brackets
" map s( :surround_brackets
" map s) :surround_brackets
" map s[ :surround_square_brackets
" map s[ :surround_square_brackets
" map s{ :surround_curly_brackets
" map s} :surround_curly_brackets

" mapping vs/hs as workspace split
" https://gist.github.com/kxxoling/dcc1c3a897e6735989f32b55ef069136#file-obsidian-vimrc-L142
exmap vs obcommand workspace:split-vertical
exmap sp obcommand workspace:split-vertical
exmap hs obcommand workspace:split-horizontal
nmap <C-w>v :vs
nmap <C-w>s :hs

" focus
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusBottom obcommand editor:focus-bottom
exmap focusTop obcommand editor:focus-top
nmap <C-w>h :focusLeft
nmap <C-w>l :focusRight
nmap <C-w>j :focusBottom
nmap <C-w>k :focusTo
