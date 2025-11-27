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

local highlights = {}
-- if vim.o.background == "dark" then
--   highlights = {
--     indicator_selected = {
--       fg = "#0DB9D7",
--     },
--     buffer = {
--       fg = "#928374",
--       bg = "#1e1e1e",
--       underline = false,
--       bold = false,
--       italic = true,
--     },
--     buffer_selected = {
--       fg = "#ebdbb2",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     tab_selected = {
--       fg = "#ebdbb2",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     tab_separator_selected = {
--       fg = "#1e1e1e",
--       sp = "#0DB9D7",
--       underline = true,
--     },
--     buffer_visible = {
--       fg = "#928374",
--       bg = "#242424",
--       sp = "#3a6982",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     group_separator = {
--       fg = "#0DB9D7",
--       bg = "#0DB9D7",
--     },
--     separator = {
--       fg = "#1e1e1e",
--       bg = "#1e1e1e",
--     },
--     separator_visible = {
--       fg = "#1e1e1e",
--       bg = "#1e1e1e",
--       sp = "#3a6982",
--       underline = true,
--     },
--     separator_selected = {
--       fg = "#1e1e1e",
--       sp = "#0DB9D7",
--       underline = true,
--     },
--     close_button = {
--       fg = "#928374",
--       bg = "#1e1e1e",
--     },
--     close_button_visible = {
--       fg = "#928374",
--       bg = "#1e1e1e",
--       sp = "#3a6982",
--       underline = true,
--     },
--     close_button_selected = {
--       fg = "#ebdbb2",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--     },
--     error_selected = {
--       fg = "#ffc0b9",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     error_diagnostic_selected = {
--       fg = "#bf908a",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     modified_selected = {
--       fg = "#b8bb26",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     diagnostic_selected = {
--       fg = "#b0a485",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     info_selected = {
--       fg = "#8cf8f7",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     info_diagnostic_selected = {
--       fg = "#69bab9",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     warning_selected = {
--       fg = "#fce094",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     warning_diagnostic_selected = {
--       fg = "#bda86f",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     hint_selected = {
--       fg = "#a6dbff",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     hint_diagnostic_selected = {
--       fg = "#7ca4bf",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--     duplicate_selected = {
--       fg = "#8a7c6e",
--       bg = "#282828",
--       sp = "#0DB9D7",
--       underline = true,
--       bold = true,
--       italic = false,
--     },
--   }
-- end

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
        separator_style = "slant",
        sort_by = "insert_at_end",
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "underline",
        },
        hover = {
          enabled = true,
          delay = 50,
          -- reveal = { "close" },
        },
        -- groups = {
        --   options = {
        --     toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        --   },
        --   items = {
        --     {
        --       name = "Default",
        --       highlight = { underline = true, sp = "#7aa2f7" },
        --       priority = 1,
        --       auto_close = true,
        --       matcher = function(buf)
        --         local name = buf.name:lower()
        --         return not name:match("%.md")
        --           and not name:match("%.txt")
        --           and not name:match("%test")
        --           and not name:match("%spec")
        --       end,
        --     },
        --     {
        --       name = "Tests", -- Mandatory
        --       highlight = { underline = true, sp = "#9d7cd8" }, -- Optional
        --       auto_close = true,
        --       priority = 2, -- determines where it will appear relative to other groups (Optional)
        --       -- icon = " ", -- Optional
        --       matcher = function(buf) -- Mandatory
        --         local name = buf.name:lower()
        --         return name:match("%test") or name:match("%spec")
        --       end,
        --     },
        --     {
        --       name = "Docs",
        --       highlight = { underline = true, sp = "#9ece6a" },
        --       auto_close = true,
        --       priority = 3,
        --       matcher = function(buf)
        --         local name = buf.name:lower()
        --         return name:match("%.md") or name:match("%.txt")
        --       end,
        --     },
        --   },
        -- },
      },
      highlights = highlights,
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
    commit = "12f86da07ae2060b738e70d2937f7850d994c84a",
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
    optional = true,
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
    optional = true,
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

  -- mode indicator
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    config = function()
      require("modes").setup()
    end,
  },
}
