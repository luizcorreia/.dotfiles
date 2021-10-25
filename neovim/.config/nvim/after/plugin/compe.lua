-- Cmp setup start
local cmp = require("cmp")

local lspkind = require("lspkind")
lspkind.init()

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- Right is for ghost_text to behave like terminal
    ["<Right>"] = cmp.mapping.confirm({ select = true }),
    -- Don't insert if I explicitly exit
    -- Start completion with C-Space to have it truly clean-up
    ["<C-e>"] = cmp.mapping.abort(),
    -- Insert instead of Select so you don't go away at `stopinsert` after `CursorHoldI`
    -- @TODOUA: I want to be able to `Select` without `stopinsert` killing it (& keep `stopinsert`)
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
      },
    }),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    {
      name = "buffer",
      priority = 2,
      keyword_length = 5,
      max_item_count = 5,
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "spell" },
  },
})

-- End Cmp related setup
