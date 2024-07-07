local bufferline = require("bufferline")

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  green  = '#9ece6a',
  violet = '#d183e8',
  grey   = '#505050',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

return {
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        style_preset = bufferline.style_preset.default,
        themable = true,
        separator_style = "thick",
        sort_by = "insert_at_end",
        hover = {
          enabled = true,
          delay = 50,
          reveal = { "close" },
        },
      },
      highlights = {
        indicator_selected = {
          fg = "#61B0D8",
        },
      },
    },
  },

  -- colorizer
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   ft = { "lua", "css", "html", "js", "ts" },
  --   optional = true,
  --   opts = {
  --     filetypes = {
  --       "*",
  --       "!neo-tree",
  --     },
  --     user_default_options = {
  --       names = false,
  --       -- Available methods are false / true / "normal" / "lsp" / "both"
  --       tailwind = false,
  --     },
  --   },
  -- },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "folke/noice.nvim",
    },
    opts = {
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
    },
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      fps = 60,
      max_height = function()
        return math.floor(vim.o.lines * 0.2)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.4)
      end,
      -- render = "wrapped-compact",
      top_down = true,
    },
  },

  --notification
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        hover = {
          silent = true,
        },
        message = {
          enabled = true,
          view = "popup",
        },
      },
      status = {
        command = {
          has = false,
        },
      },
    },
  },

  -- highlight TODO, FIXME, NOTE...
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      search = {
        command = "rg",
        args = {
          "--glob=!vendor/",
          "--glob=!node_modules/",
          "--glob=!runtime/",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
      },
    },
  },

  -- Neovim plugin for locking a buffer to a window
  -- Have you ever accidentally opened a file into your file explorer or quickfix window?
  {
    "stevearc/stickybuf.nvim",
  },

  -- pretty split window
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    enabled = false,
    dependencies = {
      { "anuvyklack/middleclass" },
      {
        "nvim-neotest/neotest",
        optional = true,
        keys = {
          {
            "<leader>ts",
            function()
              if vim.list_contains(package.loaded, "windows.nvim") then
                vim.cmd("WindowsDisableAutowidth")
                require("neotest").summary.toggle()
                vim.cmd("WindowsEnableAutowidth")
                return
              end
              require("neotest").summary.toggle()
            end,
            desc = "Toggle Summary",
          },
        },
      },
      -- { "anuvyklack/animation.nvim", enabled = true },
    },
    opts = {
      animation = { enable = false, duration = 150, fps = 60 },
      autowidth = {
        enable = true,
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = { "neotest-summary", "NvimTree", "neo-tree", "undotree", "gundo" },
      },
    },
    init = function()
      vim.o.winwidth = 30
      -- vim.o.winminwidth = 30
      vim.o.equalalways = true
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  -- helper for surround
  {
    "roobert/surround-ui.nvim",
  },
}
