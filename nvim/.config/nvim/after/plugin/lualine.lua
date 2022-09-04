local bufferline = require 'bufferline'
local colors = require('lcee.colors')

local function getWords()
  return tostring(vim.fn.wordcount().words)
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 100
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function lspServerName()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

local function harpoonStatus()
  local status = require('harpoon.mark').status()
  if status == '' then
    status = 'N'
  end
  return string.format('H:%s', status)
end

-- location icon: 
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = ' ', right = '' },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { 'mode', 'paste' },
    lualine_b = {
      { 'branch', icon = '' },
      {
        'diff',
        color_added = '#a7c080',
        color_modified = '#ffdf1b',
        color_removed = '#ff6666',
        symbols = { added = ' ', modified = '柳 ', removed = ' ' },
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        shorting_target = 40,
        cond = conditions.buffer_not_empty,
        color = { gui = 'bold' },
      },
      { getWords, cond = conditions.hide_in_width },
      {
        function()
          return '%='
        end,
      },
      { lspServerName, icon = '  LSP:', cond = conditions.hide_in_width },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      },

      { harpoonStatus },
      {
        'encoding',
        'fileformat',
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { gui = 'bold' },
      },
      'filetype',
    },
    lualine_y = {
      {
        'progress',
      },
    },
    lualine_z = {
      {
        'location',
        icon = '',
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', full_path = true } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'fugitive', 'nvim-tree', 'quickfix' },
}

bufferline.setup {
  options = {
    view = 'default',
    -- numbers = 'ordinal',
    -- For ⁸·₂
    numbers = function(opts)
      return string.format('%s·%s', opts.raise(opts.ordinal), opts.lower(opts.id))
    end,
    buffer_close_icon = '',
    modified_icon = '•',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    show_buffer_close_icons = true,
    persist_buffer_sort = true,
    diagnostics = "nvim_lsp",
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      if context.buffer:current() then
        return ''
      end
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
            or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end
  },
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      italic = false
    }
  },
  -- highlights = {
  --   modified = { fg = colors.green, bg = '#0F1E28' },
  --   modified_visible = { fg = '#3C706F', bg = '#16242E' },
  --   modified_selected = { fg = colors.cyan, bg = '#142832' },
  --   fill = { bg = '#0F1E28' },
  --   background = { bg = '#0F1E28', fg = colors.base04 },
  --   tab = { bg = '#0F1E28', fg = colors.base01 },
  --   tab_selected = { bg = '#142832' },
  --   tab_close = { bg = '#0F1E28' },
  --   buffer_visible = { bg = '#16242E' },
  -- buffer_selected = { bg = '#142832', fg = colors.white }, -- , gui = 'NONE' },
  -- indicator_selected = { fg = colors.cyan, bg = '#142832' },
  -- separator = { bg = '#62b3b2' },
  -- separator_selected = { fg = colors.cyan, bg = '#142832' },
  -- separator_visible = { bg = colors.cyan },
  -- duplicate = { bg = '#0F1E28', fg = colors.base04 }, -- gui = 'NONE' },
  -- duplicate_selected = { bg = '#142832', fg = colors.white }, --, gui = 'NONE'
  -- duplicate_visible = { bg = '#16242E' }, --, gui = 'NONE'
  -- },
}
