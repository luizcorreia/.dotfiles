local M = {}
local loop = vim.loop
local api = vim.api

function M.ConvertFile()
  local shortname = vim.fn.expand("%:t:r")
  local fullname = api.nvim_buf_get_name(0)
  Handle = loop.spawn("pandoc", {
    args = {
      fullname,
      "--to=pdf",
      "--pdf-engine=xelatex",
      "-o",
      string.format("%s.pdf", shortname),
      "--template",
      "eisvogel",
      "--table-of-contents",
      "--toc-depth",
      "6",
      "--number-sections",
      "--top-level-division=chapter",
      "--highlight-style",
      "zenburn",
      "-V",
      "lang=en-US,pt-BR",
      "-V",
      "papersize=a4paper",
      "-V",
      "lang=english,french,spanish,german,brazil",
    },
  }, function()
    print("DOCUMENT CONVERSION COMPLETE")
    Handle:close()
  end)
end

return M
