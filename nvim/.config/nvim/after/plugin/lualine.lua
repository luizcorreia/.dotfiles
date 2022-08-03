local bufferline = require 'bufferline'

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
    theme = 'nord',
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
    numbers = 'ordinal',
    buffer_close_icon = '',
    modified_icon = '•',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    show_buffer_close_icons = false,
    persist_buffer_sort = true,
    separator_style = { '', '' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
  -- highlights = {
  --   modified = { guifg = colors.green, guibg = '#0F1E28' },
  --   modified_visible = { guifg = '#3C706F', guibg = '#16242E' },
  --   modified_selected = { guifg = colors.cyan, guibg = '#142832' },
  --   fill = { guibg = '#0F1E28' },
  --   background = { guibg = '#0F1E28', guifg = colors.base04 },
  --   tab = { guibg = '#0F1E28', guifg = colors.base01 },
  --   tab_selected = { guibg = '#142832' },
  --   tab_close = { guibg = '#0F1E28' },
  --   buffer_visible = { guibg = '#16242E' },
  --   buffer_selected = { guibg = '#142832', guifg = colors.white, gui = 'NONE' },
  --   indicator_selected = { guifg = colors.cyan, guibg = '#142832' },
  --   separator = { guibg = '#62b3b2' },
  --   separator_selected = { guifg = colors.cyan, guibg = '#142832' },
  --   separator_visible = { guibg = colors.cyan },
  --   duplicate = { guibg = '#0F1E28', guifg = colors.base04, gui = 'NONE' },
  --   duplicate_selected = { guibg = '#142832', gui = 'NONE', guifg = colors.white },
  --   duplicate_visible = { guibg = '#16242E', gui = 'NONE' },
  -- },
}
