-- This file can be loaded by calling `lua require('plugins')` from your init.lua

-- Only required if you have packer configured as `opt`

require("lazy").setup({
	{

		-- basic
		"tpope/vim-repeat",
		"tpope/vim-surround",
		"tpope/vim-commentary",
		"tpope/vim-sleuth",
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",

		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { { "nvim-lua/plenary.nvim" } },
		},
		{
			"rose-pine/neovim",
			name = "rose-pine",
			config = function()
				vim.cmd("colorscheme rose-pine")
			end,
		},
		{
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({
					icons = false,
					-- your configuration comes here
					-- or leave it empty to  the default settings
					-- refer to the configuration section below
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		},
		{ "nvim-treesitter/playground" },
		{ "theprimeagen/harpoon" },
		{ "theprimeagen/refactoring.nvim" },
		{ "mbbill/undotree" },
		{ "nvim-treesitter/nvim-treesitter-context" },

		{
			"VonHeikemen/lsp-zero.nvim",
			dependencies = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },
				-- Snippets
				{ "L3MON4D3/LuaSnip" },
				{ "rafamadriz/friendly-snippets" },
			},
		},
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "jose-elias-alvarez/typescript.nvim" },
		{ "tzachar/cmp-tabnine", build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
		-- Status Line and Bufferline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "kyazdani42/nvim-web-devicons" },
		},
		"akinsho/nvim-bufferline.lua",
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		},
		{ "folke/zen-mode.nvim" },
		{ "github/copilot.vim" },
		{ "eandrju/cellular-automaton.nvim" },
		{ "laytan/cloak.nvim" },
		-- latex
		"lervag/vimtex",
	},
})
