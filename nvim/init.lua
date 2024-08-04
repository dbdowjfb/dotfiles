vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

options = { noremap = true }

map('n', '<leader>p', '"+p', options)
map({'n','v'}, '<leader>y', '"+y', options)
-- local visual_next_sentence = '<esc>v)'


cmd('colorscheme vim')



autocmd({"BufEnter"}, {
  pattern = {""},
  callback = function(args) 
	  local buf_name =  vim.api.nvim_buf_get_name(0)
	  if ((buf_name == '' or buf_name == nil ) and true 
                                                   or 
						   string.gsub(buf_name, "/[%a/]+", "") == '.notes' ) then
		  local opts = {buffer = true, noremap = true }
		  print('this is a nil buffer')
		  map('n', '<BS>', 'Gdggo',  opts) 
		  map('n', '<Tab>', "<cmd>.w !tpu<cr>", opts)
		  map('n', '<cr>', '<cmd>w !tee >> ~/.notes<cr>', opts)
	  end
  end,
})

