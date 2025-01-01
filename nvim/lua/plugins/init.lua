local Plug = vim.fn['plug#']
vim.call('plug#begin') 
Plug('kaarmu/typst.vim') 
Plug('SirVer/ultisnips')
Plug('L3MON4D3/LuaSnip', { ['do'] ='make install_jsregexp'})
Plug('nvim-lua/plenary.nvim') 
Plug('serenevoid/kiwi.nvim')
Plug('neovim/nvim-lspconfig') 
-- completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug ('nvim-telescope/telescope.nvim', { ['tag']= '0.1.8' })
Plug "nvim-treesitter/nvim-treesitter"
Plug "nvim-tree/nvim-web-devicons"
Plug "t184256/vim-boring"
vim.call('plug#end')


local cmp = require'cmp'
cmp.setup({
expand = function(args)
	vim.fn["vsnip#anonymous"](args.body)
end,
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }
})
})


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
{ name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
{ name = 'path' }
}, {
{ name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').pyright.setup {
	on_attach = on_attach,settings = {pyright = {autoImportCompletion = true,},python = {analysis = {autoSearchPaths = true,diagnosticMode = 'openFilesOnly',useLibraryCodeForTypes = true,typeCheckingMode = 'on'}}}
}

-- disable inline buffer error messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

--require("markview").setup({
--    hybrid_modes = { "n" }
--})
--
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "markdown", "markdown_inline", "python" },
  }


