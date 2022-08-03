local null_ls = require 'null-ls'
local h = require("null-ls.helpers")
local b = null_ls.builtins

local with_root_file = function(...)
  local files = { ... }
  return function(utils)
    return utils.root_has_file(files)
  end
end

local spectral = {                                                
  method = null_ls.methods.DIAGNOSTICS,                           
  filetypes = {                                                   
    'json',                                                       
    'yaml',                                                       
  },                                                              
  id = 42,                                                        
  generator = h.generator_factory {                               
    to_stdin = true,                                              
    ignore_stderr = true,                                         
    command = 'spectral',                                         
    args = {                                                      
      'lint',                                                     
      '--stdin-filepath',                                         
      '-f',                                                       
      'json',                                                     
    },                                                            
    format = 'json',                                              
    asunc = true,                                                 
    from_stderr = true,                                           
    check_exit_code = function(code)                              
        return code <= 1                                          
    end,                                                          
    on_output = function (params, done)                           
      local diags = {}                                            
      for _, d in ipairs(params.output) do                        
        table.insert(diags, {                                     
          row = d.range.start.line,                               
          col = d.range.start.character,                          
          -- end_row = d.range[1].line,                           
          -- end_col = d.range[1].character,                      
          source = "Spectral",                                    
          message = d.message,                                    
          severity = d.severity,                                  
          code = d.code,                                          
          path = d.path,                                          
        })                                                        
      end                                                         
      return done(diags)                                          
    end,                                                          
    -- on_output = h.diagnostics.from_pattern(                    
    --     {                                                      
    --         pattern = "(%d+):(%d+)%s+(%w+)%s+([%w-]+)%s+(.*)", 
    --         groups = { "row", "col", "severity", "message" },  
    --     },                                                     
    --     {                                                      
    --         severities = {                                     
    --             error = h.diagnostics.severities["error"],     
    --             warning = h.diagnostics.severities["warning"], 
    --         },                                                 
    --     }                                                      
    -- ),                                                         
  },                                                              
}                                                                 
                                                                  
require("null-ls").register(spectral)                             


local sources = {
    -- formatting
    b.formatting.prettier,
    b.formatting.fish_indent,
    b.formatting.shfmt,
    b.formatting.clang_format,
    b.formatting.trim_whitespace.with({
        filetypes = { "tmux", "snippets" },
    }),
    b.formatting.stylua.with({
        condition = with_root_file("stylua.toml"),
    }),
    -- diagnostics
    b.diagnostics.selene.with({
        condition = with_root_file("selene.toml"),
    }),
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    -- code actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,
    -- hover
    b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
    if not vim.g.started_by_firenvim then
        null_ls.setup({
            -- debug = true,
            sources = sources,
            on_attach = on_attach,
        })
    end
end

return M
