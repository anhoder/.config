return {
  "nvim-neotest/neotest",
  dependencies = {
    "V13Axel/neotest-pest",
  },
  config = function(_, opts)
    table.insert(opts.adapters, require("neotest-pest"))

    require("neotest").setup(opts)
  end,
}
