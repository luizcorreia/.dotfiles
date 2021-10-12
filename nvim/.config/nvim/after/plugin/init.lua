vim.cmd("packadd packer.nvim")
return require("packer").startup({
  function(use)
    -- Permite que o packer gerencie a si mesmo
    use("wbthomason/packer.nvim")
    use("savq/paq-nvim")
    -- Git
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")
    use("ThePrimeagen/git-worktree.nvim")

    -- Easily Create Gists
    use("mattn/vim-gist")
    use("mattn/webapi-vim")

    -- Intelisense
    use("glepnir/lspsaga.nvim")
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("windwp/nvim-autopairs")
    use("alvan/vim-closetag")
    use("mhartington/formatter.nvim")
    use("folke/lsp-colors.nvim")
    use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improve typescript experience

    -- Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
    use({
      "nvim-telescope/telescope.nvim",
      requires = { {
        "nvim-telescope/telescope-fzy-native.nvim",
        run = "make",
      } },
    })
    -- Harpoon
    use("mhinz/vim-rfc")
    use("ThePrimeagen/harpoon")

    -- Debugging
    --
    -- Autocomplete
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/nvim-compe")

    -- TreeSitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
      "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
      ft = { "lua", "typescript", "typescriptreact" },
    })
    use({ "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact" } }) -- automatically close jsx tags
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work

    -- Explorer
    use("norcalli/nvim-colorizer.lua")

    -- Comments
    use("b3nj5m1n/kommentary")

    -- Icons
    use("kyazdani42/nvim-web-devicons")
    use("ryanoasis/vim-devicons")

    -- Colors
    use("folke/tokyonight.nvim")
    use("sainnhe/everforest")
    use("morhetz/gruvbox")

    -- Status Line and Bufferline
    use("hoob3rt/lualine.nvim")

    -- Extras
    use("p00f/nvim-ts-rainbow")
    use("phaazon/hop.nvim")
    use("rmagatti/auto-session")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("wellle/targets.vim")
    use("winston0410/cmd-parser.nvim")
    use("winston0410/range-highlight.nvim")
    use("mbbill/undotree")

    -- Dashboard
    -- use("glepnir/dashboard-nvim")

    -- Markdown
    use("plasticboy/vim-markdown")
    use("iamcco/markdown-preview.nvim")
    use("vim-pandoc/vim-pandoc-syntax")
    use("elzr/vim-json")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
