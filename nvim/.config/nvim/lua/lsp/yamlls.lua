local lspconfig = require 'lspconfig'

local M = {}
M.setup = function(on_attach, capabilities)
  lspconfig.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    schemas = {
      ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema-base.yaml'] = '/*openapi.yaml',
    },
  }
end

return M
