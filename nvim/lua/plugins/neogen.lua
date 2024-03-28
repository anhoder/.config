return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  -- enabled = false,
  ft = { "php" },
  config = true,
  keys = {
    {
      "<leader>cc",
      mode = { "n" },
      function()
        require("neogen").generate({})
      end,
      desc = "Gen Comment",
    },
  },
}
