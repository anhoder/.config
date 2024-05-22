return {
  -- push code to remote by ssh
  {
    "KenN7/vim-arsync",
    ft = { "php" },
    dependencies = { "prabirshrestha/async.vim" },
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependcies = "hrsh7th/nvim-cmp",
    -- enabled = false,
    opts = {
      ignored_next_char = [=[[%*%w%%%'%[%"%.%`%$]]=],
      fast_wrap = {
        map = "<A-e>",
      },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- load big file quickly
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 1,
      pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = { -- features to disable
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    },
  },

  -- donot cut when type `c`
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "x",
    },
  },

  -- easily duplicate
  {
    "hinell/duplicate.nvim",
  },

  -- lua snip: Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    opts = {
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    },
  },

  -- syntax highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = { "lua", "luadoc", "go", "bash", "fish", "php", "phpdoc", "jsdoc", "vimdoc" },
    },
  },
}
