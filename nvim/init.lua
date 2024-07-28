vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

options = { noremap = true }

map('n', '<leader>p', '"+p', options)
map({'n','v'}, '<leader>y', '"+y', options)
map('n', '<leader><leader>', '<cmd>call feedkeys("v)#)")<cr>', options)
-- local visual_next_sentence = '<esc>v)'

-- using 'v)#)' as the rhs does not work for unknown reasons

cmd('colorscheme vim')

-- copy the content of the current buffer to the end of a file called ".notes"
map('n', 'dab', 'Gdggo', options)

autocmd({"BufEnter"}, {
  pattern = "",
  callback = function(args) 
	  local buf_name =  vim.api.nvim_buf_get_name(0)
	  if (buf_name == '' or buf_name == nil) then
		  local opts = {buffer = true, noremap = true }
		  print('this is a nil buffer')
		  map('n', '<BS>', 'Gdggo',  opts) 
		  map('n', '<Tab>', "<cmd>.w !tpu<cr>", opts)
		  map('n', '<cr>', '<cmd>w !tee >> ~/.notes<cr>', opts)
	  end
  end,
})

