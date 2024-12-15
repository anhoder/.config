return {
  -- push code to remote by ssh
  {
    "KenN7/vim-arsync",
    ft = { "php" },
    dependencies = { "prabirshrestha/async.vim" },
  },

  -- autopairs
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   dependcies = "hrsh7th/nvim-cmp",
  --   -- enabled = false,
  --   opts = {
  --     ignored_next_char = [=[[%*%w%%%'%[%"%.%`%$]]=],
  --     fast_wrap = {
  --       map = "<A-e>",
  --     },
  --   },
  --   config = function(_, opts)
  --     local npairs = require("nvim-autopairs")
  --     npairs.setup(opts)
  --     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --     local cmp = require("cmp")
  --     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --   end,
  -- },

  -- load big file quickly
  {
    "LunarVim/bigfile.nvim",
    event = { "BufEnter" },
    opts = {
      filesize = 5,
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
    event = { "BufEnter" },
  },

  -- lua snip: Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    opts = {
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    },
  },

  -- syntax highlight
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.auto_install = true
      vim.list_extend(opts.ensure_installed, {
        "luadoc",
        "go",
        "fish",
        "php",
        "phpdoc",
        "jsdoc",
        "vimdoc",
      })
    end,
  },

  -- auto close inactive buf
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
    opts = {
      retirementAgeMins = 30,
      minimumBufferNum = 5,
      notificationOnAutoClose = true,
      deleteBufferWhenFileDeleted = false,
    },
  },
}
