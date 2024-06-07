local cmp = require("cmp")

return {
  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    opts = {
      -- completion = { completeopt = "menu,menuone,noselect" },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<A-/>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Esc>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
    },
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    commit = "289eb72",
    keys = {
      {
        "<A-Tab>",
        function()
          return vim.fn["codeium#Accept"]()
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
}
