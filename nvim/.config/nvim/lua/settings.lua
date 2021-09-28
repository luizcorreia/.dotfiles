vim.g.loaded_matchparen = 1

local opt = vim.opt -- to set options

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

opt.wildmode = { "longest", "list", "full" }

-- Map leader to space
vim.g.mapleader = " "

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
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- Highlight found searches
opt.scrolloff = 8 -- Lines of context

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.linebreak = true -- Stop words being broken on wrap
opt.list = false -- Show some invisible characters
opt.numberwidth = 5 -- Make the gutter wider by default
opt.spelllang = "en"
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.cc = "80"
opt.backup = false
vim.g.netrw_liststyle = 3 -- Tree style netrw_liststyle
opt.undodir = vim.fn.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
