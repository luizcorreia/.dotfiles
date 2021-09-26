-- Bootstrap Paq when needed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path })
end

-- Plugins
require("paq-nvim")({
  "savq/paq-nvim",
  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "lewis6991/gitsigns.nvim",
  "ThePrimeagen/git-worktree.nvim",

  -- Easily Create Gists
  "mattn/vim-gist",
  "mattn/webapi-vim",

  -- Intelisense
  "glepnir/lspsaga.nvim",
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "windwp/nvim-autopairs",
  "alvan/vim-closetag",
  "mhartington/formatter.nvim",
  "folke/lsp-colors.nvim",

  -- Telescope
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "nvim-telescope/telescope.nvim",
  -- Harpoon
  "mhinz/vim-rfc",
  "ThePrimeagen/harpoon",

  -- Debugging
  --
  -- Autocomplete
  "hrsh7th/vim-vsnip",
  "hrsh7th/nvim-compe",

  -- TreeSitter
  "nvim-treesitter/nvim-treesitter",

  -- Explorer
  "norcalli/nvim-colorizer.lua",

  -- Comments
  "b3nj5m1n/kommentary",

  -- Icons
  "kyazdani42/nvim-web-devicons",

  -- Colors
  "folke/tokyonight.nvim",
  "sainnhe/everforest",
  "morhetz/gruvbox",

  -- Status Line and Bufferline
  "hoob3rt/lualine.nvim",

  -- Extras
  "p00f/nvim-ts-rainbow",
  "phaazon/hop.nvim",
  "rmagatti/auto-session",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "wellle/targets.vim",
  "winston0410/cmd-parser.nvim",
  "winston0410/range-highlight.nvim",
  "mbbill/undotree",

  -- Dashboard
  "glepnir/dashboard-nvim",

  -- Markdown
  "plasticboy/vim-markdown",
  "iamcco/markdown-preview.nvim",
  "vim-pandoc/vim-pandoc-syntax",
  "elzr/vim-json",
  "godlygeek/tabular",
})
