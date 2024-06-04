noremap ; :
noremap : ;

noremap <Leader>m <cmd>!make<cr>

nnoremap <F5> "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
noremap <C-c> "+y
noremap <C-v> "+p

luafile ~/.config/nvim/lazy.lua
luafile  ~/.config/nvim/send2cmd.lua

set tabstop=2
set shiftwidth=2
set expandtab

let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')


