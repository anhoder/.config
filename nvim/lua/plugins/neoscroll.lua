return {
  "karb94/neoscroll.nvim",
  -- enabled = not require("utils.gui").is_gui(),
  enabled = true,
  config = function()
    local scroll = require("neoscroll")
    scroll.setup({})

    -- vim.keymap.set({ "n", "v", "i", "s", "c", "o", "t" }, "<ScrollWheelUp>", function()
    --   scroll.scroll(-0.15, false, 30)
    -- end, { noremap = true })
    -- vim.keymap.set({ "n", "v", "i", "s", "c", "o", "t" }, "<ScrollWheelDown>", function()
    --   scroll.scroll(0.15, false, 30)
    -- end, { noremap = true })
  end,
}
