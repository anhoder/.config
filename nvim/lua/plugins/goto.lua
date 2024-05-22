return {
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          jump_labels = true,
        },
      },
      label = {
        rainbow = {
          enabled = true,
          shade = 6,
        },
      },
    },
    keys = {
      -- disable the default flash keymap
      { "s", mode = { "n", "x", "o" }, false },
      {
        "D",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },

  -- glance, pretty goto like vscode
  {
    "dnlhc/glance.nvim",
    opts = function()
      local glance = require("glance")
      -- vim.cmd("hi! GlanceListNormal guibg=#393939 guifg=#909090 gui=NONE")
      -- vim.cmd("hi! GlanceListCursorLine gui=bold guibg=#393939 guifg=#ebdbb2")
      vim.cmd("hi! GlanceWinBarTitle gui=bold guibg=#393939 guifg=#b8bb26")
      vim.cmd("hi! link GlanceFoldIcon GruvboxOrange")
      vim.cmd("hi! link GlanceIndent GruvboxOrange")
      vim.cmd("hi! link GlanceBorderTop Comment")
      vim.cmd("hi! link GlancePreviewBorderBottom Comment")
      vim.cmd("hi! link GlanceListBorderBottom Comment")
      return {
        height = 22,
        detached = true,
        preview_win_opts = {
          cursorline = true,
          number = true,
          wrap = false,
        },
        border = {
          enable = true,
          top_char = "─",
          bottom_char = "─",
        },
        list = {
          position = "left",
          width = 0.3,
        },
        mappings = {
          list = {
            ["<C-A-Right>"] = glance.actions.enter_win("preview"), -- Focus list window
          },
          preview = {
            ["q"] = glance.actions.close,
            ["<Esc>"] = glance.actions.enter_win("list"), -- Focus list window
            ["<C-A-Left>"] = glance.actions.enter_win("list"), -- Focus list window
          },
        },
        hooks = {
          before_open = function(results, open, jump, _)
            if #results == 1 then
              jump(results[1])
            else
              open(results)
              vim.keymap.set({ "n", "i", "v" }, "<2-LeftMouse>", "<CR>", { remap = true })
            end
          end,
          before_close = function()
            vim.keymap.del({ "n", "i", "v" }, "<2-LeftMouse>")
          end,
        },
      }
    end,
  },
}
