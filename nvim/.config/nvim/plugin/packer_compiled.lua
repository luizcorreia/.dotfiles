-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/luizcorreia/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/luizcorreia/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/luizcorreia/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/luizcorreia/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/luizcorreia/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { "require('plugins.luasnip')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/cmp-vsnip"
  },
  ["dial.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/dial.nvim"
  },
  ["filetype.nvim"] = {
    config = { "require('plugins.filetype')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  ["git-messenger.vim"] = {
    config = { "require('plugins.gitmessenger')" },
    keys = { { "", "<Plug>(git-messenger)" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["git-worktree.nvim"] = {
    config = { "require('plugins.git-worktree')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('plugins.git')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gundo.vim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/gundo.vim"
  },
  harpoon = {
    config = { "require('plugins.harpoon')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('plugins.indent-blankline')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    commands = { "LspTrouble" },
    config = { "\27LJ\1\2U\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('plugins.lualine')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    config = { "vim.cmd[[doautocmd BufEnter]]" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nord-vim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "require('plugins.autopairs')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    wants = { "nvim-cmp" }
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-base16"
  },
  ["nvim-cmp"] = {
    config = { "require('plugins.cmp')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "require('plugins.notify')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "require('plugins.treesitter')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-web-nonicons"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/nvim-web-nonicons"
  },
  ["package-info.nvim"] = {
    config = { "require('plugins.package-info')" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/package-info.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "require('plugins.refactoring')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/refactoring.nvim"
  },
  ["registers.nvim"] = {
    config = { "require('plugins.registers')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/registers.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require('plugins.telescope')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-boxdraw"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-boxdraw"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cutlass"] = {
    config = { "require('plugins.cutlass')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-cutlass"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-illuminate"] = {
    config = { "require('plugins.illuminate')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-json"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-json"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-matchup"] = {
    config = { "require('plugins.matchup')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rfc"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-rfc"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-sneak"] = {
    config = { "require('plugins.sneak')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-subversive"] = {
    config = { "require('plugins.subversive')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-teal"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-teal"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    config = { "require('plugins.vsnip')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-wakatime"
  },
  ["vim-yoink"] = {
    config = { "require('plugins.yoink')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/vim-yoink"
  },
  ["zen-mode.nvim"] = {
    config = { "require('plugins.zen')" },
    loaded = true,
    path = "/home/luizcorreia/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('plugins.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: vim-cutlass
time([[Config for vim-cutlass]], true)
require('plugins.cutlass')
time([[Config for vim-cutlass]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('plugins.indent-blankline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: registers.nvim
time([[Config for registers.nvim]], true)
require('plugins.registers')
time([[Config for registers.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('plugins.lualine')
time([[Config for lualine.nvim]], false)
-- Config for: vim-subversive
time([[Config for vim-subversive]], true)
require('plugins.subversive')
time([[Config for vim-subversive]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
require('plugins.matchup')
time([[Config for vim-matchup]], false)
-- Config for: vim-yoink
time([[Config for vim-yoink]], true)
require('plugins.yoink')
time([[Config for vim-yoink]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('plugins.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
require('plugins.vsnip')
time([[Config for vim-vsnip]], false)
-- Config for: refactoring.nvim
time([[Config for refactoring.nvim]], true)
require('plugins.refactoring')
time([[Config for refactoring.nvim]], false)
-- Config for: harpoon
time([[Config for harpoon]], true)
require('plugins.harpoon')
time([[Config for harpoon]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require('plugins.luasnip')
time([[Config for LuaSnip]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require('plugins.cmp')
time([[Config for nvim-cmp]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require('plugins.autopairs')
time([[Config for nvim-autopairs]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
require('plugins.illuminate')
time([[Config for vim-illuminate]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('plugins.git')
time([[Config for gitsigns.nvim]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
require('plugins.filetype')
time([[Config for filetype.nvim]], false)
-- Config for: vim-sneak
time([[Config for vim-sneak]], true)
require('plugins.sneak')
time([[Config for vim-sneak]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
require('plugins.notify')
time([[Config for nvim-notify]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
require('plugins.zen')
time([[Config for zen-mode.nvim]], false)
-- Config for: git-worktree.nvim
time([[Config for git-worktree.nvim]], true)
require('plugins.git-worktree')
time([[Config for git-worktree.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspTrouble lua require("packer.load")({'lsp-trouble.nvim'}, { cmd = "LspTrouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <Plug>(git-messenger) <cmd>lua require("packer.load")({'git-messenger.vim'}, { keys = "<lt>Plug>(git-messenger)", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-treesitter-textsubjects'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-ts-context-commentstring', 'nvim-ts-autotag', 'nvim-treesitter-textsubjects'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-ts-context-commentstring', 'nvim-ts-autotag', 'nvim-treesitter-textsubjects'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType json ++once lua require("packer.load")({'package-info.nvim'}, { ft = "json" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
