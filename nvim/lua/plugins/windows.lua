return {
  "anuvyklack/windows.nvim",
  event = "WinNew",
  -- enabled = false,
  dependencies = {
    { "anuvyklack/middleclass" },
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
}
