local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  ---@diagnostic disable-next-line: undefined-field
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        buffer_previewer_maker = new_maker,
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
        winblend = 0,
        pumblend = 0,
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
    event = { "VeryLazy" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    event = { "VeryLazy" },
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
