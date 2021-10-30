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
    theme = "nord",
    component_separators = { left = " ", right = " " },
    section_separators = { left = " ", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode", "paste" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "filename", path = 1 },
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
    lualine_c = { { "filename", full_path = true } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive", "nvim-tree", "quickfix" },
})
