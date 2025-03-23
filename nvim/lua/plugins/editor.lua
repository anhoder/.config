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
    opts = {
      ignored_next_char = [=[[%*%w%%%'%[%"%.%`%$]]=],
      fast_wrap = {
        map = "<A-e>",
      },
    },
    -- config = function(_, opts)
    --   local npairs = require("nvim-autopairs")
    --   npairs.setup(opts)
    --   local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    --   local cmp = require("cmp")
    --   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    -- end,
  },

  -- load big file quickly
  -- NOTE: replace by snacks bigfile
  -- {
  --   "LunarVim/bigfile.nvim",
  --   event = { "BufEnter" },
  --   opts = {
  --     filesize = 5,
  --     pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
  --     features = { -- features to disable
  --       "indent_blankline",
  --       "illuminate",
  --       "lsp",
  --       -- "treesitter",
  --       "syntax",
  --       "matchparen",
  --       "vimopts",
  --       "filetype",
  --     },
  --   },
  -- },

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

  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      { "<leader>S", false },
    },
    opts = {
      scroll = { enabled = false },
      animate = {
        enabled = not vim.g.neovide,
        fps = 120,
      },
      bigfile = {
        enabled = true,
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },
      gitbrowse = {
        enabled = true,
        notify = false,
        url_patterns = {
          ["gitlab%..*"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },
      lazygit = {
        configure = true,
      },
      indent = {
        priority = 1,
        enabled = true,
        -- can be a list of hl groups to cycle through
        hl = "SnacksIndent",
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 20, -- ms per step
            total = 500, -- maximum duration
          },
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "│",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        },
      },
      scope = {
        enabled = false,
      },
      quickfile = {
        enabled = true,
      },
      words = {
        enabled = true,
      },
      statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
    },
  },
}
