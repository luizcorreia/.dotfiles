local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local nvim_status = require "lsp-status"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<space>cr", vim.lsp.buf.rename }
  telescope_mapper("<space>ca", "lsp_code_actions", nil, true)

  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "<space>gI", handlers.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('tj.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>rr", "LspRestart" }

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

