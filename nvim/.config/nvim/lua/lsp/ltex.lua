-- local Dictionary_file = {
--     ["pt-BR"] = { vim.fn.getenv("HOME") .. ".config/nvim/spell/dictionary.txt" } -- there is another way to find ~/.config/nvim ?
-- }
-- local DisabledRules_file = {
--     ["pt-BR"] = { vim.fn.getenv("HOME") .. ".config/nvim/spell/disable.txt" } -- there is another way to find ~/.config/nvim ?
-- }
-- local FalsePositives_file = {
--     ["pt-BR"] = { vim.fn.getenv("HOME") .. ".config/nvim/spell/false.txt" } -- there is another way to find ~/.config/nvim ?
-- }

local M = {}

M.setup = function(on_attach, capabilities)
    require("lspconfig").ltex.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return M
-- dictionary_file = Dictionary_file,
-- disabledrules_file = DisabledRules_file,
-- falsepostivies_file = FalsePositives_file,
