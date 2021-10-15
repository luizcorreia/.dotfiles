vim.cmd("packadd packer.nvim")
vim.cmd([[packadd vimball]])

local has = function(x)
  return vim.fn.has(x) == 1
end

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local is_wsl = (function()
  local output = vim.fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end)()

return require("packer").startup({
  function(use)
    local local_use = function(first, second, opts)
      opts = opts or {}

      local plug_path, home
      if second == nil then
        plug_path = first
        home = "luizcorreia"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/plugins/" .. plug_path)) == 1 then
        opts[1] = "~/plugins/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    local py_use = function(opts)
      if not has("python3") then
        return
      end

      use(opts)
    end
    -- Permite que o packer gerencie a si mesmo
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    -- Git
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")
    -- Git worktree utility6
    use("ThePrimeagen/git-worktree.nvim")
    -- GIT:
    use("TimUntersberger/neogit")

    -- Github integration
    if vim.fn.executable("gh") == 1 then
      use("pwntester/octo.nvim")
    end
    use("ruifm/gitlinker.nvim")

    -- Sweet message committer
    use("rhysd/committia.vim")
    use("sindrets/diffview.nvim")

    -- Floating windows are awesome :)
    use({
      "rhysd/git-messenger.vim",
      keys = "<Plug>(git-messenger)",
    })

    -- Easily Create Gists
    use("mattn/vim-gist")
    use("mattn/webapi-vim")

    -- LSP Plugins
    use("neovim/nvim-lspconfig")
    use("wbthomason/lsp-status.nvim")
    use("onsails/lspkind-nvim")
    use({
      "folke/lsp-trouble.nvim",
      cmd = "LspTrouble",
      config = function()
        -- Can use P to toggle auto movement
        require("trouble").setup({
          auto_preview = false,
          auto_fold = true,
        })
      end,
    })

    use("rcarriga/nvim-notify")

    -- Intelisense
    use("glepnir/lspsaga.nvim")
    use("windwp/nvim-autopairs")
    use("alvan/vim-closetag")
    use("mhartington/formatter.nvim")
    use("folke/lsp-colors.nvim")
    use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improve typescript experience
    use({
      "antoinemadec/FixCursorHold.nvim",
      run = function()
        vim.g.curshold_updatime = 1000
      end,
    })
    use({
      "prettier/vim-prettier",
      ft = { "html", "javascript", "typescript" },
      run = "yarn install",
    })

    -- Telescope
    use("nvim-lua/plenary.nvim", {
      rocks = "lyaml",
    })
    use("nvim-lua/popup.nvim")
    use({ "nvim-telescope/telescope-hop.nvim" })
    use({
      "nvim-telescope/telescope.nvim",
      requires = { {
        "nvim-telescope/telescope-fzy-native.nvim",
        run = "make",
      } },
    })
    use("tami5/sql.nvim")
    use("nvim-telescope/telescope-frecency.nvim")
    use("nvim-telescope/telescope-cheat.nvim")
    use({ "nvim-telescope/telescope-arecibo.nvim", rocks = { "openssl", "lua-http-parser" } })
    use("nvim-telescope/telescope-media-files.nvim")
    -- Harpoon
    use("mhinz/vim-rfc")
    use("ThePrimeagen/harpoon")

    -- Debugging
    --
    -- Autocomplete
    use("L3MON4D3/LuaSnip")
    -- use("hrsh7th/vim-vsnip")

    -- Completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")

    -- Completion stuff
    -- local_use "rofl.nvim"

    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use({ "liuchengxu/vista.vim", cmd = "Vista" })

    use("jbyuki/one-small-step-for-vimkind")

    -- TreeSitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("vigoux/architext.nvim")

    use("JoosepAlviste/nvim-ts-context-commentstring")
    use({
      "mfussenegger/nvim-ts-hint-textobject",
      config = function()
        vim.cmd([[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]])
        vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]])
      end,
    })
    use({
      "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
      ft = { "lua", "typescript", "typescriptreact" },
    })
    use({ "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact" } }) -- automatically close jsx tags
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work

    -- Comments
    -- TEXT MANIUPLATION
    use("godlygeek/tabular") -- Quickly align text by pattern
    use("tpope/vim-commentary") -- Easily comment out lines or objects
    use("tpope/vim-repeat") -- Repeat actions better
    use("tpope/vim-abolish") -- Cool things with words!
    use("tpope/vim-characterize")
    use({ "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } })

    use({
      "AndrewRadev/splitjoin.vim",
      keys = { "gJ", "gS" },
    })

    -- Icons
    use("kyazdani42/nvim-web-devicons")
    if not is_wsl then
      use("yamatsum/nvim-web-nonicons")
    end
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
    use({
      "tweekmonster/haunted.vim",
      cmd = "Haunt",
    })

    use({
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
    })

    -- Quickfix enhancements. See :help vim-qf
    use("romainl/vim-qf")

    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    })

    -- Pretty colors
    use("norcalli/nvim-colorizer.lua")
    use({
      "norcalli/nvim-terminal.lua",
      config = function()
        require("terminal").setup()
      end,
    })

    -- Undo helper
    use("sjl/gundo.vim")

    -- Crazy good box drawing
    use("gyim/vim-boxdraw")

    -- Better increment/decrement
    use("monaqa/dial.nvim")

    --   FOCUSING:
    local use_folke = true
    if use_folke then
      use("folke/zen-mode.nvim")
      use("folke/twilight.nvim")
    end

    -- Markdown
    use("plasticboy/vim-markdown")
    use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" })
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
