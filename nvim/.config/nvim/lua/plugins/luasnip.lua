local ls = require("luasnip")
local extras = require 'luasnip.extras'
local types = require 'luasnip.util.types'

-- some shorthands...
local snippet = ls.snippet
local text = ls.text_node
local f = ls.function_node
local insert = ls.insert_node
local l = extras.lambda
local match = extras.match

-- Every unspecified option will be set to the default.
ls.config.set_config({
    history = true,
    region_check_events = 'CursorMoved,CursorHold,InsertEnter',
    delete_check_events = 'InsertLeave',
    ext_opts = {
      [types.choiceNode] = {
	active = {
	  virt_text = { { '●', 'Operator'  }  },
	},
      },
      [types.insertNode] = {
	active = {
	  virt_text = { { '●', 'Type'  }  },
      }
    }

  },
  enable_autosnippets = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {
  all = {
  },
  html = {
  },
}

-- enable html snippets in javascript/javascript(REACT)
ls.snippets.javascript = ls.snippets.html
ls.snippets.javascriptreact = ls.snippets.html
ls.snippets.typescriptreact = ls.snippets.html
require("luasnip/loaders/from_vscode").load({include = {"html"}})

-- You can also use lazy loading so you only get in memory snippets of languages you use
require'luasnip/loaders/from_vscode'.lazy_load()
