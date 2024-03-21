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
      },
      extensions = {
        frecency = {
          default_workspace = "CWD",
        },
      },
    },
    config = function()
      local colors = require("utils.gruvbox").base_30
      vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", colors.red, colors.black2))
      vim.cmd(string.format("hi TelescopeNormal guibg=%s", colors.darker_black))
      vim.cmd(string.format("hi TelescopePreviewTitle guifg=%s guibg=%s", colors.black, colors.green))
      vim.cmd(string.format("hi TelescopePromptTitle guifg=%s guibg=%s", colors.black, colors.red))
      vim.cmd(string.format("hi TelescopeSelection guifg=%s guibg=%s", colors.white, colors.black2))
      vim.cmd(string.format("hi TelescopeResultsDiffAdd guifg=%s", colors.green))
      vim.cmd(string.format("hi TelescopeResultsDiffChange guifg=%s", colors.yellow))
      vim.cmd(string.format("hi TelescopeResultsDiffDelete guifg=%s", colors.red))
      vim.cmd(string.format("hi TelescopeMatching guifg=%s guibg=%s", colors.blue, colors.one_bg))

      -- for borderless
      -- vim.cmd(string.format("hi TelescopeBorder guifg=%s guibg=%s", colors.darker_black, colors.darker_black))
      -- vim.cmd(string.format("hi TelescopePromptBorder guifg=%s guibg=%s", colors.black2, colors.black2))
      -- vim.cmd(string.format("hi TelescopePromptNormal guifg=%s guibg=%s", colors.white, colors.black2))
      -- vim.cmd(string.format("hi TelescopeResultsTitle guifg=%s guibg=%s", colors.darker_black, colors.darker_black))
      -- vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", colors.red, colors.black2))

      -- for bordered
      vim.cmd(string.format("hi TelescopeBorder guifg=%s ", colors.one_bg3))
      vim.cmd(string.format("hi TelescopePromptBorder guifg=%s ", colors.one_bg3))
      vim.cmd(string.format("hi TelescopeResultsTitle guifg=%s guibg=%s", colors.black, colors.green))
      vim.cmd(string.format("hi TelescopePreviewTitle guifg=%s guibg=%s", colors.black, colors.blue))
      vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", colors.red, colors.black))
      vim.cmd(string.format("hi TelescopeNormal guibg=%s", colors.black))
      vim.cmd(string.format("hi TelescopePromptNormal guibg=%s", colors.black))
    end,
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
