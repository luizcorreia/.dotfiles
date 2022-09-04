-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local u = require 'lcee.utils'
local protocol = vim.lsp.protocol
local lsp = vim.lsp
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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

local border_opts = { border = "single", focusable = false, scope = "line" }
vim.diagnostic.config({ virtual_text = false, float = border_opts })

local eslint_disabled_buffers = {}

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

-- track buffers that eslint can't format to use prettier instead
lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
    local client = lsp.get_client_by_id(ctx.client_id)
    if not (client and client.name == "eslint") then
        goto done
    end

    for _, diagnostic in ipairs(result.diagnostics) do
        if diagnostic.message:find("The file does not match your project config") then
            local bufnr = vim.uri_to_bufnr(result.uri)
            eslint_disabled_buffers[bufnr] = true
        end
    end

    ::done::
    return lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, config)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- local lsp_formatting = function(bufnr)
--     vim.lsp.lsp_formatting({
--     -- vim.lsp.buf.format({
--         filter = function(client)
--             -- apply whatever logic you want (in this example, we'll only use null-ls)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
-- end

-- local lsp_formatting = function(bufnr)
--     local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
--     vim.lsp.lsp_formatting({
--         -- vim.lsp.buf.format({
--         bufnr = bufnr,
--         filter = function(client)
--             if client.name == "eslint" then
--                 return not eslint_disabled_buffers[bufnr]
--             end

--             if client.name == "null-ls" then
--                 return not u.table.some(clients, function(_, other_client)
--                     return other_client.name == "eslint" and not eslint_disabled_buffers[bufnr]
--                 end)
--             end
--         end,
--     })
-- end
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '[a', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']a', vim.diagnostic.goto_next, bufopts)

    -- if client.supports_method("textDocument/formatting") then
    --     u.buf_command(bufnr, "LspFormatting", function()
    --         lsp_formatting(bufnr)
    --     end)

    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         command = "LspFormatting",
    --     })
    -- end
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
                -- vim.lsp.buf.formatting_sync()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- lsp_formatting(bufnr)
            end,
        })
    end
    require("illuminate").on_attach(client)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs({
    "gopls",
    "graphql",
    "bashls",
    "eslint",
    "jsonls",
    "null-ls",
    "pyright",
    "sumneko",
    "tsserver",
    "rust_analyzer",
}) do
    require("lsp." .. server).setup(on_attach, capabilities)
end

-- suppress irrelevant messages
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("%[lspconfig%]") then
        return
    end

    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
