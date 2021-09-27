local function getWords()
  return tostring(vim.fn.wordcount().words)
end

local function harpoonStatus()
  local status = require("harpoon.mark").status()
  if status == "" then
    status = "N"
  end
  return string.format("H:%s", status)
end
-- location icon: 
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
    component_separators = { " ", " " },
    section_separators = { " ", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode", "paste" },
    lualine_b = {
      { "branch", icon = " " },
      { "diff", color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      "filename",
      { getWords },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      { harpoonStatus },
      "encoding",
      "filetype",
    },
    lualine_y = {
      {
        "progress",
      },
    },
    lualine_z = {
      {
        "location",
        icon = "",
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {},
    lualine_b = { "branch" },
    lualine_c = { "filename", file_status = true, path = 1 },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "fugitive", "nvim-tree" },
})
