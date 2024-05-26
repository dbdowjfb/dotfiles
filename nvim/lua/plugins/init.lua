return {
	{	"/hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
  init = function()
    local cmp = require'cmp'

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-j>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = {{
        name = 'nvim_lsp' ,
      }, 
      { name = 'buffer' },
      --	{ name = 'rime'}
      },

    experimental = {
      ghost_text = true,
    }
  })
  end
  },
	{
	"SirVer/ultisnips",
	},
  {
  "neovim/nvim-lspconfig",
  config = function() 
    require'lspconfig'.jedi_language_server.setup{
    }
  end 
  },
	{
		"hrsh7th/cmp-nvim-lsp"
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-cmdline",
	},
	{
		"Ninlives/cmp-rime",
		lazy = false
	},
	{
		"Ninlives/pyrime",
	},
}
