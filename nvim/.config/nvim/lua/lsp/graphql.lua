local lspconfig = require 'lspconfig'
-- local util = require 'lspconfig/util'

local M = {}
M.setup = function(on_attach, capabilities, root_pattern)
  lspconfig.graphql.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "graphql", "typescriptreact", "javascriptreact", "javascript", "typescript" }
    -- root_dir = util.root_pattern()
  }
end

return M
