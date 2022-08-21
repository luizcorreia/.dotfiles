vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/init.lua source <afile> | PackerCompile
  augroup end
]]

return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("sbdchd/neoformat")

    -- basic
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    -- improves %, now with treesitter
    use 'andymass/vim-matchup'

    -- Simple plugins can be specified as strings
    use("TimUntersberger/neogit")

    -- TJ created lodash of neovim
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- All the things
    -- Completion Engine
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use 'hrsh7th/cmp-path'
    use("tzachar/cmp-tabnine", { run = "./install.sh" })
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use 'rafamadriz/friendly-snippets'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jose-elias-alvarez/typescript.nvim'
    use 'folke/lua-dev.nvim'

    -- Autocomplete pairs
    use 'windwp/nvim-autopairs'

    -- Primeagen doesn"t create lodash
    use("ThePrimeagen/git-worktree.nvim")
    use("ThePrimeagen/harpoon")

    use("mbbill/undotree")

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use('arcticicestudio/nord-vim')

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    -- Status Line and Bufferline
    use('hoob3rt/lualine.nvim')
    use 'akinsho/nvim-bufferline.lua'

    -- Markdown
    use("plasticboy/vim-markdown")
    use {
        'iamcco/markdown-preview.nvim', -- preview markdown output in browser
        opt = true,
        ft = { 'markdown' },
        config = 'vim.cmd[[doautocmd BufEnter]]',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview',
    }
    use("b0o/schemastore.nvim") -- simple access to json-language-server schemae

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    }
    -- go
    -- Go Lang Bundle
    use { 'fatih/vim-go', run = 'GoInstallBinaries' }
    -- highlights and allows moving between variable references
    use 'RRethy/vim-illuminate'


end)
