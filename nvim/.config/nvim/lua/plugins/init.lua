-- _ = vim.cmd [[packadd packer.nvim]]
-- _ = vim.cmd [[packadd vimball]]
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local is_wsl = (function()
  local output = vim.fn.systemlist 'uname -r'
  return not not string.find(output[1] or '', 'WSL')
end)()

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  local config = function(name)
    return string.format("require('plugins.%s')", name)
  end

  local use_with_config = function(path, name)
    use { path, config = config(name) }
  end

  -- basic
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  -- use 'tpope/vim-commentary'
  use 'tpope/vim-sleuth'
  use {
    { 'lewis6991/gitsigns.nvim', config = config 'git' },
    { 'tpope/vim-fugitive', requires = 'tpope/vim-rhubarb' },
  }
  use {
    'mattn/vim-gist',
    requires = 'mattn/webapi-vim',
  }
  use { 'pwntester/octo.nvim' }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  -- Git worktree utility
  use_with_config('ThePrimeagen/git-worktree.nvim', 'git-worktree')
  -- Floating windows are awesome :)
  use 'rhysd/git-messenger.vim'
  use 'mbbill/undotree'

  -- Editor Config
  use { 'editorconfig/editorconfig-vim' }

  use_with_config('andymass/vim-matchup', 'matchup') -- improves %, now with treesitter

  -- registers
  use_with_config('svermeulen/vim-subversive', 'subversive') -- adds substitute operator
  -- use_with_config("svermeulen/vim-cutlass", "cutlass") -- separates cut and delete operations
  use_with_config('tversteeg/registers.nvim', 'registers') -- shows register contents intelligently
  -- use_with_config("svermeulen/vim-yoink", "yoink") -- improves paste

  -- Completion Engine
  use {
    'hrsh7th/nvim-cmp',
    config = config 'cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'ray-x/cmp-treesitter' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-calc' },
      { 'Saecki/crates.nvim' },
      { 'f3fora/cmp-spell' },
      { 'hrsh7th/cmp-cmdline' },
      { 'tzachar/cmp-tabnine', run = './install.sh' },
    },
  }

  use { 'L3MON4D3/LuaSnip', config = config 'luasnip', requires = {
    'rafamadriz/friendly-snippets',
  } }

  use {
    'windwp/nvim-autopairs', -- autocomplete pairs
    config = config 'autopairs',
    wants = 'nvim-cmp',
  }

  -- integrationso
  use 'nvim-lua/popup.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {
        'nvim-telescope/telescope-github.nvim',
        'nvim-telescope/telescope-node-modules.nvim',
        'cljoly/telescope-repo.nvim',
        run = 'make',
      },
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  }

  -- lsp
  use 'neovim/nvim-lspconfig'
  use { 'wbthomason/lsp-status.nvim', config = config 'lspstatus' }
  use { 'onsails/lspkind-nvim', config = config 'lspkind' }
  use {
    'folke/lsp-trouble.nvim',
    cmd = 'LspTrouble',
    config = function()
      -- Can use P to toggle auto movement
      require('trouble').setup {
        auto_preview = false,
        auto_fold = true,
      }
    end,
  }
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/nvim-lsp-installer'

  use_with_config('RRethy/vim-illuminate', 'illuminate') -- highlights and allows moving between variable references

  -- development
  use {
    'vuki656/package-info.nvim', -- manage package.json
    config = config 'package-info',
    requires = 'MunifTanjim/nui.nvim',
    ft = { 'json' },
  }
  use_with_config('rcarriga/nvim-notify', 'notify')

  -- Status Line and Bufferline
  use_with_config('hoob3rt/lualine.nvim', 'lualine')
  use { 'akinsho/nvim-bufferline.lua' }

  -- Harpoon
  use 'mhinz/vim-rfc'
  use_with_config('ThePrimeagen/harpoon', 'harpoon')

  -- Refactoring
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = config 'refactoring',
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config 'treesitter',
  }
  use 'nvim-treesitter/playground'
  use {
    'RRethy/nvim-treesitter-textsubjects', -- adds smart text objects
    ft = { 'lua', 'typescript', 'typescriptreact' },
  }
  use { 'windwp/nvim-ts-autotag', ft = { 'typescript', 'typescriptreact' } }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', ft = { 'typescript', 'typescriptreact' } }

  -- visual
  use { -- themes
    'arcticicestudio/nord-vim',
    'RRethy/nvim-base16',
  }
  use_with_config('lukas-reineke/indent-blankline.nvim', 'indent-blankline') -- show indentation guides

  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  if not is_wsl then
    use 'yamatsum/nvim-web-nonicons'
  end
  use 'ryanoasis/vim-devicons'

  -- misc
  use 'teal-language/vim-teal'
  use_with_config('nathom/filetype.nvim', 'filetype') -- greatly reduce startup time
  use_with_config('kosayoda/nvim-lightbulb', 'lightbulb')

  -- Undo helper
  use 'sjl/gundo.vim'

  -- Crazy good box drawing
  use 'gyim/vim-boxdraw'

  -- Better increment/decrement
  use 'monaqa/dial.nvim'

  --   FOCUSING:
  local use_folke = true
  if use_folke then
    use_with_config('folke/zen-mode.nvim', 'zen')
    use 'folke/twilight.nvim'
  end

  -- Markdown
  use_with_config('plasticboy/vim-markdown', 'vim-markdown')
  use { 'rhysd/vim-grammarous' }
  use {
    'iamcco/markdown-preview.nvim', -- preview markdown output in browser
    opt = true,
    ft = { 'markdown' },
    config = 'vim.cmd[[doautocmd BufEnter]]',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
  }
  use 'vim-pandoc/vim-pandoc-syntax'

  -- Wakatime
  use 'wakatime/vim-wakatime'

  -- i3 Hight
  use 'mboughaba/i3config.vim'
  -- Python
  use { 'tmhedberg/SimpylFold', ft = 'python' }
  -- JS/TS
  use { 'othree/yajs.vim' }
  use { 'MaxMEllon/vim-jsx-pretty' }
  use { 'heavenshell/vim-jsdoc' }
  use { 'elzr/vim-json' }
  use { 'neoclide/jsonc.vim' }
  use { 'HerringtonDarkholme/yats.vim' }
  use { 'Quramy/vison' }
  use { 'jxnblk/vim-mdx-js' }
  -- HTML
  use { 'othree/html5.vim' }
  use { 'mattn/emmet-vim' }
  use { 'posva/vim-vue' }
  use { 'leafOfTree/vim-svelte-plugin' }
  use { 'skwp/vim-html-escape' }
  use { 'kana/vim-textobj-user' }
  use { 'whatyouhide/vim-textobj-xmlattr' }
  use { 'pedrohdz/vim-yaml-folds' }
  -- CSS
  use { 'hail2u/vim-css3-syntax' }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  }

  -- Rust
  use { 'rust-lang/rust.vim' }
  use { 'racer-rust/vim-racer' }

  -- go
  -- Go Lang Bundle
  use { 'fatih/vim-go', run = 'GoInstallBinaries' }

  -- vimwiki
  use { 'vimwiki/vimwiki', config = config 'vimwiki' }
  use 'tbabej/taskwiki'
end)
