return {
  "anuvyklack/windows.nvim",
  event = "WinNew",
  dependencies = {
    { "anuvyklack/middleclass" },
    -- { "anuvyklack/animation.nvim", enabled = true },
  },
  opts = {
    animation = { enable = false, duration = 150, fps = 60 },
    autowidth = { enable = true },
  },
  init = function()
    vim.o.winwidth = 30
    -- vim.o.winminwidth = 30
    vim.o.equalalways = true
  end,
}
