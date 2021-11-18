local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- local u = require("utils")
local lspkind = require 'lspkind'

local source_mapping = {
  buffer = '◉ Buffer',
  nvim_lsp = '👐 LSP',
  nvim_lua = '🌙 Lua',
  cmp_tabnine = '💡 Tabnine',
  path = '🚧 Path',
  luasnip = '🌜 LuaSnip',
  vsnip = '  Vsnip',
}

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
    -- expand = function(args)
    -- 	vim.fn["vsnip#anonymous"](args.body)
    -- end,
    get_trigger_characters = function(trigger_characters)
      return vim.tbl_filter(function(char)
        return char ~= ' ' and char ~= '\t'
      end, trigger_characters)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    -- ["<Tab>"] = function(fallback)
    -- 	if cmp.visible() then
    -- 		cmp.select_next_item()
    -- 	elseif vim.fn["vsnip#available"](1) > 0 then
    -- 		u.input("<Plug>(vsnip-expand-or-jump)")
    -- 	else
    -- 		fallback()
    -- 	end
    -- end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'cmp_tabnine' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'spell' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == 'cmp_tabnine' then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. ' ' .. menu
        end
        vim_item.kind = ''
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
  -- formatting = {
  -- 	-- Youtube: How to set up nice formatting for your sources.
  -- 	format = lspkind.cmp_format({
  -- 		with_text = true,
  -- 		menu = {
  -- 			buffer = "[buf]",
  -- 			nvim_lsp = "[LSP]",
  -- 			nvim_lua = "[api]",
  -- 			path = "[path]",
  -- 			luasnip = "[snip]",
  -- 			vsnip = "[snip]",
  -- 			gh_issues = "[issues]",
  -- 		},
  -- 	}),
  -- },
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },
}
require('luasnip/loaders/from_vscode').load {}
