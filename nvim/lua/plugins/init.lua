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
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = {
        { name = 'ultisnips',}, 
        {
        name = 'nvim_lsp' ,
      }, 
      { name = 'buffer' },
      { name = 'rime', 
      option = {
        max_candidates = 10 , -- 设置过高会影响补全速度。
        shared_data_dir = '/usr/share/rime-data',
        user_data_dir = vim.fn.getenv('HOME') .. '/.local/share/cmp-rime',
      } 
    }
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
    require'lspconfig'.jedi_language_server.setup({
    })
    require'lspconfig'.jdtls.setup({})
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
    dir = "~/Projects/cmp-rime", --這裏克隆cmp-rime 的地址 
    keys = { "<leader>cc" }
  },
  {"williamboman/mason.nvim"}, --lsp package manager
  {"williamboman/mason-lspconfig.nvim"}, --lsp package manager configs
  {
    "nvim-java/nvim-java",
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-refactor',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      }
    },
  },
}
