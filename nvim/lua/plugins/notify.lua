return {
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
    render = "wrapped-compact",
    top_down = true,
  },
}
