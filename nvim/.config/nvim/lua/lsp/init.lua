local u = require 'utils'

local lsp = vim.lsp
local protocol = lsp.protocol
-- lspkind Icon setup
require('lspkind').init {}
-- gitsigns setup
require('gitsigns').setup {
  numhl = true,
  signcolumn = false,
}
protocol.CompletionItemKind = {
  ' Text', -- Text
  ' Method', -- Method
  ' Function', -- Function
  ' Constructor', -- Constructor
  '  Field', -- Field
  ' Variable', -- Variable
  '  Class', -- Class
  'ﰮ  Interface', -- Interface
  '  Module', -- Module
  ' Property', -- Property
  '  Unit', -- Unit
  '  Value', -- Value
  '  Enum', -- Enum
  '  Keywork', -- Keyword
  '﬌  Snippet', -- Snippet
  '  Color', -- Color
  '  File', -- File
  '  Reference', -- Reference
  '  Folder', -- Folder
  '  EnumMember', -- EnumMember
  '  Constant', -- Constant
  '  Struct', -- Struct
  ' Event', -- Event
  'ﬦ', -- Operator
  ' TypeParameter', -- TypeParameter
}

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  update_in_insert = true,
  virtual_text = {
      true,
      spacing = 6,
      --severity_limit='Error'  -- Only show virtual text on error
    },
})

local border_opts = { border = 'single', focusable = false, scope = 'line' }

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, border_opts)

global.lsp = {
  border_opts = border_opts,
}

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- commands
  u.lua_command('LspFormatting', 'vim.lsp.buf.formatting()')
  u.lua_command('LspHover', 'vim.lsp.buf.hover()')
  u.lua_command('LspRename', 'vim.lsp.buf.rename()')
  u.lua_command('LspDiagPrev', 'vim.lsp.diagnostic.goto_prev({ float = global.lsp.border_opts })')
  u.lua_command('LspDiagNext', 'vim.lsp.diagnostic.goto_next({ float = global.lsp.border_opts })')
  u.lua_command('LspDiagLine', 'vim.lsp.diagnostic.show_line_diagnostics(global.lsp.border_opts)')
  u.lua_command('LspSignatureHelp', 'vim.lsp.buf.signature_help()')
  u.lua_command('LspTypeDef', 'vim.lsp.buf.type_definition()')

  -- bindings
  u.buf_map('n', 'gi', ':LspRename<CR>', nil, bufnr)
  u.buf_map('n', 'gy', ':LspTypeDef<CR>', nil, bufnr)
  u.buf_map('n', 'K', ':LspHover<CR>', nil, bufnr)
  u.buf_map('n', '[a', ':LspDiagPrev<CR>', nil, bufnr)
  u.buf_map('n', ']a', ':LspDiagNext<CR>', nil, bufnr)
  u.buf_map('n', '<Leader>a', ':LspDiagLine<CR>', nil, bufnr)
  u.buf_map('n', '<C-k>', ':LspSignatureHelp<CR>', nil, bufnr)

  -- telescope
  u.buf_map('n', 'gr', ':LspRef<CR>', nil, bufnr)
  u.buf_map('n', 'gd', ':LspDef<CR>', nil, bufnr)
  u.buf_map('n', 'ga', ':LspAct<CR>', nil, bufnr)
  u.buf_map('n', 'gT', ':LspTypeDef<CR>', nil, bufnr)

  if client.resolved_capabilities.document_formatting then
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end

  require('illuminate').on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
-- LSP Prevents inline buffer annotations
lsp.diagnostic.show_line_diagnostics()
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  -- This sets the spacing and the prefix, obviously.
  virtual_text = {
    spacing = 4,
    prefix = '',
  },
})

require('lsp.tsserver').setup(on_attach, capabilities)
require('lsp.sumneko').setup(on_attach, capabilities)
-- require('lsp.diagnosticls').setup(on_attach, capabilities)
require('lsp.null-ls').setup(on_attach)
require('lsp.gopls').setup(on_attach, capabilities)
require('lsp.pyright').setup(on_attach, capabilities)
require('lsp.cssls').setup(on_attach, capabilities)
require('lsp.yamlls').setup(on_attach, capabilities)
require('lsp.spectral').setup(on_attach, capabilities)
-- require("lsp.diagnosticls").setup(on_attach, capabilities)
-- require("lsp.eslint").setup(on_attach, capabilities)
