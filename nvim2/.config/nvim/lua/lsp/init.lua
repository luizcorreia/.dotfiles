local u = require("utils")
local sumneko = require("lsp.sumneko")
local null_ls = require("lsp.null-ls")
local tsserver = require("lsp.tsserver")

local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = true,
  virtual_text = false,
})

local border_opts = { border = "single", focusable = false }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

global.lsp = {
  border_opts = border_opts,
}

local on_attach = function(client, bufnr)
  -- commands
  u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
  u.lua_command("LspHover", "vim.lsp.buf.hover()")
  u.lua_command("LspRename", "vim.lsp.buf.rename()")
  u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({ float = global.lsp.border_opts })")
  u.lua_command("LspDiagNext", "vim.lsp.diagnostic.goto_next({ float = global.lsp.border_opts })")
  u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.border_opts)")
  u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
  u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

  -- bindings
  u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
  u.buf_map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
  u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
  u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
  u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
  u.buf_map("n", "<Leader>a", ":LspDiagLine<CR>", nil, bufnr)
  u.buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

  -- telescope
  u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
  u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
  u.buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end

  -- require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

tsserver.setup(on_attach, capabilities)
sumneko.setup(on_attach, capabilities)
null_ls.setup(on_attach)
