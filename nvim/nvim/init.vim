noremap ; :
noremap : ;
map  <F5> <cmd>-1r!date +'\%Y-\%m-\%d \%H:\%M:\%S'<cr> 
noremap <Leader>m !make

noremap <C-c> "+y
noremap <C-v> "+p

luafile ~/.config/nvim/lazy.lua
luafile  ~/.config/nvim/send2cmd.lua

set tabstop=2
set shiftwidth=2
set expandtab

let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')
