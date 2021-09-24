if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

" Git
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Easily Create Gists
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'

if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'windwp/nvim-autopairs'

   " HARPOON!!
 Plug 'mhinz/vim-rfc'
 Plug 'ThePrimeagen/harpoon'
  
  " telescope requirements...
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'ThePrimeagen/git-worktree.nvim'

  " nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'


    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
endif

" Intellisense
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-dap'
" Interactive code
Plug 'metakirby5/codi.vim'
" Smooth Scrool
Plug 'psliwka/vim-smoothie'
" Neovim in Browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) }}
"webdev
" Auto change html tags
Plug 'AndrewRadev/tagalong.vim'


"Plug 'vimwiki/vimwiki'
"Plug 'tbabej/taskwiki'
Plug 'gruvbox-community/gruvbox'
 
 " Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
 " tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'


Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

Plug 'wfxr/minimap.vim'


call plug#end()

