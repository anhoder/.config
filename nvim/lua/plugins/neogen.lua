return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  enabled = false,
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
