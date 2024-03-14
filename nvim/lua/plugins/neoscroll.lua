-- neovide 不使用neoscroll
-- if vim.g.neovide then
--   return {}
-- end

return {
  "karb94/neoscroll.nvim",
  config = function()
    local scroll = require("neoscroll")
    scroll.setup({})

    -- vim.keymap.set({ "n", "v", "i", "s", "c", "o" }, "<ScrollWheelUp>", function()
    --   scroll.scroll(-0.15, false, 30)
    -- end, { noremap = true })
    -- vim.keymap.set({ "n", "v", "i", "s", "c", "o" }, "<ScrollWheelDown>", function()
    --   scroll.scroll(0.15, false, 30)
    -- end, { noremap = true })
  end,
}
