local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

local server_name = 'spectral'
local bin_name = 'spectral-language-server'

-- Check if the config is already defined (useful when reloading this file)
if not lspconfig[server_name] then
  configs[server_name] = {
    default_config = {
      cmd = { bin_name, '--stdio' },
      filetypes = { 'yaml', 'yml' },
      root_dir = util.root_pattern('.spectral.yaml', '.spectral.yml'),
      single_file_support = true,
      settings = {
        enable = true,
        run = 'onType',
        validateLanguages = { 'yaml', 'yml' },
      },
    },
    docs = {
      description = [[
          https://github.com/luizcorreia/spectral-language-server
           `A flexible JSON/YAML linter for creating automated style guides, with baked in support for OpenAPI v2 & v3.`

          `spectral-language-server` can be installed via `npm`:
          ```sh
          npm i -g spectral-language-server
          ```
        See [vscode-spectral](https://github.com/stoplightio/vscode-spectral#extension-settings) for configuration options.
        ]],
    },
  }
end

local M = {}
local settings = {
  filetypes = {
    'json',
    'yaml',
    'yml',
  },
}
M.setup = function(on_attach, capabilities)
  lspconfig.spectral.setup {
    -- cmd = { 'spectral lint %' },
    filetypes = settings.filetypes,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
