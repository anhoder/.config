return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = false,
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
}
