local actions = require("telescope.actions")

return {
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
  },
}
