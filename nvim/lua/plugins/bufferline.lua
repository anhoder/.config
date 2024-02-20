local bufferline = require("bufferline")
return {
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
}
