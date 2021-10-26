-- Example config in Lua
vim.g.gruvbox_italic_functions = true
vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.gruvbox_colors = { hint = "orange", error = "#ff0000" }

vim.g.gruvbox_flat_style = "dark"
vim.g.gruvbox_transparent = true
-- Load the colorscheme
vim.cmd([[colorscheme nord]])
