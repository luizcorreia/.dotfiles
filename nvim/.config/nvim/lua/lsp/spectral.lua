local lspconfig = require 'lspconfig'

local M = {}
local settings = {
  filetypes = {
    'json',
    'yaml',
  },
}
M.setup = function(on_attach, capabilities)
  lspconfig.spectral.setup {
    cmd = { 'spectral lint %' },
    filetypes = settings.filetypes,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
