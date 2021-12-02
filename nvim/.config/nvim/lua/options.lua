vim.g.loaded_matchparen = 1

local opt = vim.opt -- to set options

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore = opt.wildignore + { '*.o', '*~', '*.pyc', '*pycache*', '**/node_modules/**' }

opt.wildmode = { 'longest', 'list', 'full' }
-- opt.guifont = 'DroidSansMono Nerd Font 11'
opt.guifont = 'VictorMono Nerd Font Mono 11'
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.background = 'dark'
vim.g.t_Co = 256

opt.showmode = false -- Don't display mode
opt.showcmd = true
opt.cmdheight = 1 -- More space for displaying messages
opt.incsearch = true -- Shows the match while typing
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Do not ignore case with capitals
opt.hidden = true -- Enable background buffers
opt.cursorline = true -- Highlight the current line
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Put new windows right of current
opt.splitbelow = true -- Put new windows below current
opt.updatetime = 100 -- Make updates happen faster
opt.hlsearch = true -- Highlight found searches
opt.scrolloff = 8 -- Lines of context

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(' ', 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = 'marker'
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = 'all' -- Just turn the dang bell off

-- opt.clipboard = "unnamedplus"

opt.inccommand = 'split'
opt.swapfile = false -- Living on the edge

opt.mouse = 'n'

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done
opt.list = false -- Show some invisible characters
opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = '▷─', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
  space = ' ',
}

-- set fillchars=eob:~
opt.fillchars = {
  diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = ' ', -- remove ugly vertical lines on window division
}

opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.encoding = 'utf-8' -- Set default encoding to UTF-8
opt.linebreak = true -- Stop words being broken on wrap
opt.numberwidth = 5 -- Make the gutter wider by default
opt.spelllang = 'en_us,pt_br'
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.cc = '80'
opt.backup = false
vim.g.netrw_liststyle = 3 -- Tree style netrw_liststyle
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 15
opt.undodir = vim.fn.getenv 'HOME' .. '/.vim/undodir'
opt.undofile = true
opt.shell = 'zsh' -- shell to use for `!`, `:!`, `system()` etc.

-- Disable Buitin
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
