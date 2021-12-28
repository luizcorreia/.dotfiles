local fn = vim.fn
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-----------------------------------------------------------------------------//
-- Message output on vim actions {{{1
-----------------------------------------------------------------------------//
vim.opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}
-----------------------------------------------------------------------------//
-- Timings {{{1
-----------------------------------------------------------------------------//
vim.opt.updatetime = 300
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
-----------------------------------------------------------------------------//
-- Window splitting and buffers {{{1
-----------------------------------------------------------------------------//
--- NOTE: remove this once 0.6 lands as it is now default
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = 'hor'
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
vim.o.switchbuf = 'useopen,uselast'
vim.opt.fillchars = {
  vert = '▕', -- alternatives │
  fold = ' ',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '╱', -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
-----------------------------------------------------------------------------//
-- Diff {{{1
-----------------------------------------------------------------------------//
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
vim.opt.diffopt = vim.opt.diffopt + {
  'vertical',
  'iwhite',
  'hiddenoff',
  'foldcolumn:0',
  'context:4',
  'algorithm:histogram',
  'indent-heuristic',
}
-----------------------------------------------------------------------------//
-- Format Options {{{1
-----------------------------------------------------------------------------//
-- TODO: w, {v, b, l}
vim.opt.formatoptions = vim.opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore
-----------------------------------------------------------------------------//
-- Folds {{{1
-----------------------------------------------------------------------------//
vim.opt.foldtext = 'v:lua.as.folds()'
vim.opt.foldopen = vim.opt.foldopen + 'search'
vim.opt.foldlevelstart = 5
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
-----------------------------------------------------------------------------//
-- Quickfix {{{1
-----------------------------------------------------------------------------//
--- FIXME: Need to use a lambda rather than a lua function directly
--- @see https://github.com/neovim/neovim/pull/14886
-- vim.o.quickfixtextfunc = '{i -> v:lua.as.qftf(i)}'
-----------------------------------------------------------------------------//
-- Grepprg {{{1
-----------------------------------------------------------------------------//
-- Use faster grep alternatives if possible
-- if lcee.executable 'rg' then
--   vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
--   vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
-- elseif lcee.executable 'ag' then
--   vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
--   vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
-- end
-----------------------------------------------------------------------------//
-- Wild and file globbing stuff in command mode {{{1
-----------------------------------------------------------------------------//
-- vim.opt.wildcharm = fn.char2nr(lcee.replace_termcodes [[<Tab>]])
vim.opt.wildmode = { 'longest', 'list', 'full' } -- Shows a menu bar as opposed to an enormous list
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
vim.opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '.DS_Store',
  'tags.lock',
}
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 3 -- Make popup window translucent
-----------------------------------------------------------------------------//
-- Display {{{1
-----------------------------------------------------------------------------//
vim.opt.conceallevel = 2
vim.opt.cc = '80'
vim.opt.equalalways = true
vim.opt.breakindentopt = 'sbr'
vim.opt.linebreak = true -- lines wrap at words rather than random characters
vim.opt.synmaxcol = 1024 -- don't syntax highlight long lines
-- FIXME: use 'auto:2-4' when the ability to set only a single lsp sign is restored
--@see: https://github.com/neovim/neovim/issues?q=set_signs
vim.opt.relativenumber = true -- Show line numbers
vim.opt.number = true -- But show the actual number for the line we're on
vim.opt.signcolumn = 'yes:2'
vim.opt.ruler = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1 -- Set command line height to two lines
vim.opt.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
--- This is used to handle markdown code blocks where the language might
--- be set to a value that isn't equivalent to a vim filetype
vim.g.markdown_fenced_languages = {
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}
-----------------------------------------------------------------------------//
-- List chars {{{1
-----------------------------------------------------------------------------//
vim.opt.list = true -- invisible chars
vim.opt.listchars = {
  eol = nil,
  tab = '│ ',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}
-----------------------------------------------------------------------------//
-- Indentation
-----------------------------------------------------------------------------//
vim.opt.wrap = false
vim.opt.wrapmargin = 2
vim.opt.textwidth = 80
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-----------------------------------------------------------------------------//
-- vim.o.debug = "msg"
--- NOTE: remove this once 0.6 lands, it is now default
vim.opt.joinspaces = false
vim.opt.gdefault = true
vim.opt.pumheight = 15
vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.hlsearch = false
vim.opt.autowriteall = true -- automatically :write before running commands and changing files
-- vim.opt.clipboard = { 'unnamedplus' }
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.guifont = 'Fira Code Regular Nerd Font Complete Mono:h14'
-----------------------------------------------------------------------------//
-- Emoji {{{1
-----------------------------------------------------------------------------//
-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.opt.emoji = false
-----------------------------------------------------------------------------//
--- NOTE: remove this once 0.6 lands, it is now default
vim.opt.inccommand = 'split'
-----------------------------------------------------------------------------//
-- Cursor {{{1
-----------------------------------------------------------------------------//
-- This is from the help docs, it enables mode shapes, "Cursor" highlight, and blinking
vim.opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}
vim.opt.cursorline = true

-- vim.opt.cursorlineopt = 'screenline,number'
-----------------------------------------------------------------------------//
-- Title {{{1
-----------------------------------------------------------------------------//
-- vim.opt.titlestring = require('as.external').title_string() or ' ❐ %t %r %m'
vim.opt.titleold = fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
vim.opt.title = true
vim.opt.titlelen = 70
-----------------------------------------------------------------------------//
-- Utilities {{{1
-----------------------------------------------------------------------------//
vim.opt.showmode = false
vim.opt.sessionoptions = {
  'globals',
  'buffers',
  'curdir',
  'help',
  'winpos',
  -- "tabpages",
}
vim.opt.viewoptions = { 'cursor', 'folds' } -- save/restore just these (with `:{mk,load}view`)
vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode
vim.opt.belloff = 'all' -- Just turn the dang bell off
-----------------------------------------------------------------------------//
-- Shada (Shared Data)
-----------------------------------------------------------------------------//
-- NOTE: don't store marks as they are currently broke i.e.
-- are incorrectly resurrected after deletion
-- replace '100 with '0 the default which stores 100 marks
-- add f0 so file marks aren't stored
-- @credit: wincent
vim.opt.shada = "!,'0,f0,<50,s10,h"
-------------------------------------------------------------------------------
-- BACKUP AND SWAPS {{{
-------------------------------------------------------------------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = vim.fn.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.swapfile = false
-- The // at the end tells Vim to use the absolute path to the file to create the swap file.
-- This will ensure that swap file name is unique, so there are no collisions between files
-- with the same name from different directories.
vim.opt.directory = fn.stdpath 'data' .. '/swap//'
if fn.isdirectory(vim.o.directory) == 0 then
  fn.mkdir(vim.o.directory, 'p')
end
--}}}
-----------------------------------------------------------------------------//
-- Match and search {{{1
-----------------------------------------------------------------------------//
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true -- Searches wrap around the end of the file
vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1
-----------------------------------------------------------------------------//
-- Spelling {{{1
-----------------------------------------------------------------------------//
vim.opt.spellsuggest:prepend { 12 }
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
vim.opt.fileformats = { 'unix', 'mac', 'dos' }
vim.opt.spelllang = 'pt,en_us'
-----------------------------------------------------------------------------//
-- Mouse {{{1
-----------------------------------------------------------------------------//
vim.opt.mouse = 'n'
vim.opt.mousefocus = true
-----------------------------------------------------------------------------//
-- these only read ".vim" files
vim.opt.secure = true -- Disable autocmd etc for project local vimrc files.
vim.opt.exrc = true -- Allow project local vimrc files example .nvimrc see :h exrc
-----------------------------------------------------------------------------//
-- Git editor
-----------------------------------------------------------------------------//
-- if lcee.executable 'nvr' then
--   vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
--   vim.env.EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
-- end
-- vim:foldmethod=marker
