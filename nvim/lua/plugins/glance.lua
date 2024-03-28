return {
  "dnlhc/glance.nvim",
  opts = function()
    local glance = require("glance")
    vim.cmd("hi! GlanceListNormal guibg=#393939 guifg=#909090 gui=NONE")
    vim.cmd("hi! GlanceWinBarTitle gui=bold guibg=#393939 guifg=#b8bb26")
    vim.cmd("hi! link GlanceFoldIcon GruvboxOrange")
    vim.cmd("hi! link GlanceIndent GruvboxOrange")
    vim.cmd("hi! link GlanceBorderTop Comment")
    vim.cmd("hi! link GlancePreviewBorderBottom Comment")
    vim.cmd("hi! link GlanceListBorderBottom Comment")
    vim.cmd("hi! GlanceListCursorLine gui=bold guibg=#393939 guifg=#ebdbb2")
    return {
      height = 22,
      detached = function(winid)
        return vim.api.nvim_win_get_width(winid) < 100
      end,
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
}
