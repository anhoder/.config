local cmp = require("cmp")
return {
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
      ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
  },
  -- init = function()
  --   cmp.setup.cmdline(":", {
  --     completion = { completeopt = "menu,menuone,noselect" },
  --     mapping = cmp.mapping.preset.cmdline(),
  --     sources = cmp.config.sources({
  --       { name = "path" },
  --     }, {
  --       { name = "cmdline" },
  --     }),
  --     matching = { disallow_symbol_nonprefix_matching = false },
  --   })
  -- end,
}
