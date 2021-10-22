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
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
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
require("lspconfig").tsserver.setup({
  capabilities = capabilities,
})
require("lspconfig").hls.setup({
  capabilities = capabilities,
})

require("lspconfig").yamlls.setup({
  capabilities = capabilities,
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
        'https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml: ["/openapi.yml", "/openapi.yaml"]',
      },
    },
  },
})

local sumneko_root_path = "/home/luizcorreia/tools/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
require("lspconfig").sumneko_lua.setup({
  capabilities = capabilities,
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

require("lspconfig").diagnosticls.setup({
  filetypes = {
    "javascript",
    "javascriptreact",
    "json",
    "typescript",
    "typescriptreact",
    "css",
    "less",
    "scss",
    "yaml",
  },
  init_options = {
    linters = {
      eslint = {
        command = "eslint_d",
        rootPatterns = { ".git", ".eslintrc" },
        debounce = 100,
        args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
        sourceName = "eslint_d",
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endline = "endline",
          endColumn = "endColumn",
          message = " [eslint] ${message} [${ruleId}]",
          security = "severity",
        },
        securities = {
          [2] = "error",
          [1] = "warning",
        },
      },
    },
    filetypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
    },
    formatters = {
      eslint_d = {
        command = "eslint_d",
        args = { "--stdin", "--stdin-filename", "%filename", "--fix-to-stdout" },
        rootPatterns = {},
      },
      prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "%filename" },
      },
    },
    formatFiletypes = {
      css = "prettier",
      javascript = "eslint_d",
      javascriptreact = "eslint_d",
      json = "prettier",
      scss = "prettier",
      less = "prettier",
      typescript = "eslint_d",
      typescriptreact = "eslint_d",
      markdown = "prettier",
    },
  },
})

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  -- This sets the spacing and the prefix, obviously.
  virtual_text = {
    spacing = 4,
    prefix = "",
  },
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
