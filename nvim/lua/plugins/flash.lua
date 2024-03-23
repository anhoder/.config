return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {},
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
}
