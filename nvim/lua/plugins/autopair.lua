return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependcies = "hrsh7th/nvim-cmp",
    -- enabled = false,
    opts = {
      ignored_next_char = [=[[%*%w%%%'%[%"%.%`%$]]=],
      fast_wrap = {
        map = "<A-e>",
      },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = false,
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      fastwarp = {
        multi = true,
        {},
        { faster = true, map = "<A-e>", cmap = "<A-E>" },
      },
    },
  },
}
