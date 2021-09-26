local protocol = require("vim.lsp.protocol")
-- lspkind Icon setup
require("lspkind").init({})
-- gitsigns setup
require("gitsigns").setup({
  numhl = true,
  signcolumn = false,
})
protocol.CompletionItemKind = {
  " Text", -- Text
  " Method", -- Method
  " Function", -- Function
  " Constructor", -- Constructor
  "  Field", -- Field
  " Variable", -- Variable
  "  Class", -- Class
  "ﰮ  Interface", -- Interface
  "  Module", -- Module
  " Property", -- Property
  "  Unit", -- Unit
  "  Value", -- Value
  "  Enum", -- Enum
  "  Keywork", -- Keyword
  "﬌  Snippet", -- Snippet
  "  Color", -- Color
  "  File", -- File
  "  Reference", -- Reference
  "  Folder", -- Folder
  "  EnumMember", -- EnumMember
  "  Constant", -- Constant
  "  Struct", -- Struct
  " Event", -- Event
  "ﬦ", -- Operator
  " TypeParameter", -- TypeParameter
}

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- LSP Server config
require("lspconfig").cssls.setup({
  cmd = { "vscode-css-language-server --stdio" },
  capabilities = capabilities,
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
})
require("lspconfig").tsserver.setup({})
require("lspconfig").hls.setup({})
require("lspconfig").yamlls.setup({
  settings = {
    yaml = {
      customTags = {
        "!Equals sequence",
        "!FindInMap sequence",
        "!GetAtt scalar",
        "!GetAZs scalar",
        "!ImportValue scalar",
        "!Join sequence scalar",
        "!Ref scalar",
        "!Select sequence",
        "!Split sequence",
        "!Sub scalar",
        "!And sequence",
        "!Not sequence",
        "!Equals sequence",
        "!Sub sequence",
        "!ImportValue scalar",
        "!If sequence",
      },
      schemas = {
        'https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json: ["/template.yaml", "/template.yml"]',
      },
    },
  },
})

local sumneko_root_path = "/home/luizcorreia/tools/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
require("lspconfig").sumneko_lua.setup({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = flse,
})

-- LSP Saga config & keys https://github.com/glepnir/lspsaga.nvim
local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_icon = " ",
  definition_preview_icon = "  ",
  dianostic_header_icon = "   ",
  error_sign = " ",
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  hint_sign = "⚡",
  infor_sign = "",
  warn_sign = "",
})
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
map("n", "<leader>ch", ":Lspsaga hover_doc<CR>", { silent = true })
map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
