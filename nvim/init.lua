vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local cmd = vim.cmd

options = { noremap = true }

map('n', '<leader>p', '"+p', options)
map({'n','v'}, '<leader>y', '"+y', options)
map('n', '<leader><leader>', '<cmd>call feedkeys("v)#)")<cr>', options)
-- using 'v)#)' as the rhs does not work for unknown reasons

cmd('colorscheme vim')

