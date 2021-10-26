-- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`
require("impatient")

-- Leader key -> "<space>"
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = " "

-- I set some global variables to use as configuration throughout my config.
-- These don't have any special meaning.
vim.g.snippets = "luasnip"

-- Setup globals that I expect to be always available.
--  See `./lua/tj/globals/*.lua` for more information.
require("lc.globals")

-- Turn off builtin plugins I do not use.
require("lc.disable_builtin")

-- Force loading of astronauta first.
--vim.cmd([[runtime plugin/astronauta.vim]])

-- Neovim builtin LSP configuration
-- require("lc.lsp")

-- Telescope BTW
-- require("lc.telescope.setup")
-- require("lc.telescope.mappings")

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
-- local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables

-- initialize global object for config
global = {}

require("settings")
-- Load the colorscheme
-- cmd([[colorscheme gruvbox]]) -- Put your favorite colorscheme here
cmd([[colorscheme nord]]) -- Put your favorite colorscheme here

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
-- g.netrw_altv = 1
g.netrw_winsize = 15
-- g.netrw_sort_sequence = [\/]$,*

require("range-highlight").setup({})
require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

-- Colourscheme config
vim.g.background = "dark"

-- This little monkey has to go after termguicolors is set or gets upset
require("colorizer").setup()

-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.
-- Source: http:--thejakeharding.com/tutorial/2012/06/13/using-spell-check-in-vim.html
vim.api.nvim_exec(
  [[
augroup markdownSpell
    autocmd!
    autocmd FileType markdown,md,txt setlocal spell spelllang=pt_br
    autocmd BufRead,BufNewFile *.md,*.txt,*.markdown setlocal spell spelllang=pt_br
augroup END
]],
  false
)

vim.api.nvim_exec(
  [[
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
]],
  false
)

vim.api.nvim_exec([[autocmd TermOpen * setlocal nonumber norelativenumber]], false)

-- Hop
require("hop").setup()

-- Harpoon
require("harpoon").setup()

-- Give me some fenced codeblock goodness
g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }

-------------------- COMMANDS ------------------------------
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") -- disabled in visual mode

-- Prettier function for formatter
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--double-quote" },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    json = { prettier },
    typescript = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier },
    yaml = { prettier },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
  },
})
-- Runs Formatter on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.css,*.scss,*.md,*.html,*.lua,*.yaml : FormatWrite
augroup END
]],
  true
)
-- source remaining config
require("maps")
require("lsp")
require("plugins")
require("lc.commands")