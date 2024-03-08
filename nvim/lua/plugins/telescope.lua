local actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-f>"] = actions.preview_scrolling_left,
            ["<C-k>"] = actions.preview_scrolling_right,
            ["<ScrollWheelDown>"] = actions.move_selection_next,
            ["<ScrollWheelUp>"] = actions.move_selection_previous,
            ["<D-Up>"] = require("telescope.actions").cycle_history_prev,
            ["<D-Down>"] = require("telescope.actions").cycle_history_next,
          },
        },
      },
      extensions = {
        frecency = {
          default_workspace = "CWD",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    event = { "VeryLazy" },
    enabled = false,
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      "stevearc/dressing.nvim",
    },
    opts = {
      default = {
        disable = true, -- disable any unkown pickers (recommended)
        use_cwd = true, -- differentiate scoring for each picker based on cwd
        sorting = "frecency", -- sorting: options: 'recent' and 'frecency'
      },
      pickers = {
        ["persisted#persisted"] = {
          disable = false,
          use_cwd = false,
          sorting = "frecency",
        },
      },
    },
  },
}
