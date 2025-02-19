require("plugins")
local map = vim.keymap.set 
local cmd = vim.cmd local autocmd =
vim.api.nvim_create_autocmd 
iline = vim.api.nvim_set_current_line

vim.g.mapleader = " " 
vim.g.maplocalleader = "\\"

vim.opt.timeoutlen = 500000  -- cannot be too big (I don't know why). But 500000 is big enough 
vim.opt.hidden = true

options = { noremap = true }
vim.opt.background = 'dark'
vim.go.laststatus=0 -- hide statusline
cmd('colorscheme 256_noir')

map('n', '<leader>p', '"+p', options) 
map({'n','v'}, '<leader>y', '"+y',
	options) 
map('n','<leader>q','<cmd>qa!<cr>',options)
map({'n','i'}, '<F5>', function() 
	iline(date()) 
end
	, options)
map('n', 
	'<leader>w','<cmd>w<cr>',options)
-- map('<F5>', function () 
-- 	local time = os.date('%Y-%m-%d %H:%M:%S')
-- 	  vim.api.nvim_set_current_line(time)
--   end, options)
-- map({'n', 'v'},'<esc>', ':', options)
--map({'n', 'v'}, ';', ':', options) 
--map('n', ':', ';', options)
vim.api.nvim_create_user_command('Shuflines', '1,$!shuf', {})
map('n', '<leader>ss', '<cmd>Shuflines<cr>', options)
map('n', '<leader><leader>', ':', options)
map('n', '<leader>e', ":w <bar> exec '!python3 '.shellescape('%')<CR>")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
function save_context()
	local current_line = vim.api.nvim_get_current_line()
	local row, col =
	unpack(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win()))
	-- get the last line I learned the function ...get current_buf/win from
	-- this reddit page:
	-- https://old.reddit.com/r/neovim/comments/17pi95q/is_there_a_way_using_the_neovim_api_to_get_the/
	local last_line =
	vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), row - 1, row,
		false)[1] local line_before_last_line =
	vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), row - 2, row -
		1, false)[1]

	-- if the current line and last line are both empty then ...
	if line_before_last_line == '' and last_line == '' then
		-- run a command with nvim `<cmd>w !tee >> ~/.notes<cr>`
		vim.api.nvim_del_current_line()
		vim.api.nvim_del_current_line()
		vim.cmd('w !tee >> ~/.notes')
	else 
		-- the normal <cr> key
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true,
			true, true), 'n', true)
	end
end

autocmd({"BufEnter"}, { pattern = {""}, callback = function(args) local
	buf_name =  vim.api.nvim_buf_get_name(
		vim.api.nvim_get_current_buf()) 
	if (buf_name == '' or buf_name ==
		nil  ) then 
		local opts = { buffer = true, noremap = true }
		-- map('n', '<BS>', 'Gdggo',  opts)
		map({'n','i'}, '<C-c><C-c>', '<cmd>w !tee >> ~/.notes|echo "saved to"<cr>', opts)
		--		  map('i', '<cr>', '<cmd>lua save_context()<cr>', opts) if
		--		  at the beginning of a line, then enter
	end 
end, })

-- Setup Custom wiki path if required
---- Setup Custom wiki path if required
---
---
local kiwi_path = require('kiwi').utils.get_wiki_path()
require('kiwi').setup({ { name = "personal", path = kiwi_path, } })
-- Use default path 
local kiwi = require('kiwi')

-- Necessary keybindings
vim.keymap.set('n', '<leader>o', function() cmd('cd'.. kiwi_path)
	kiwi.open_wiki_index() end , {}) vim.keymap.set('n', '<leader>t', kiwi.todo.toggle, {}) 
require'lspconfig'.pyright.setup{}

function date() 
	output=  os.date([[%Y-%m-%d %H:%M:%S]])
	return output
end



