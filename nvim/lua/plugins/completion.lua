-- local cmp = require("cmp")

return {
  -- completion
  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- commmit = "7e348da6e5085ac447144a2ef4b637220ba27209",
  --   dependencies = {
  --     "hrsh7th/cmp-cmdline",
  --   },
  --   opts = {
  --     -- completion = { completeopt = "menu,menuone,noselect" },
  --     preselect = cmp.PreselectMode.None,
  --     mapping = cmp.mapping.preset.insert({
  --       ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --       ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --       ["<D-Bslash>"] = cmp.mapping.complete(),
  --       ["<C-e>"] = cmp.mapping.abort(),
  --       ["<Esc>"] = cmp.mapping.abort(),
  --       ["<CR>"] = cmp.mapping.confirm({ select = true }),
  --     }),
  --   },
  -- },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
      },
      keymap = {
        ["<A-/>"] = { require("blink.cmp").show },
      },
    },
  },

  -- codeium
  -- WARN: nvim和phpstorm都开启使用codeium的话，会导致CPU飙高🥲，先不用吧
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   enabled = false,
  --   keys = {
  --     {
  --       "<A-Tab>",
  --       function()
  --         return vim.fn["codeium#Accept"]()
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = { "i", "s" },
  --     },
  --   },
  -- },

  -- github copilot
  {
    "github/copilot.vim",
    -- enabled = false,
  },

  -- auto gen comment/anotation
  {
    "danymat/neogen",
    config = true,
    keys = {
      {
        "<leader>cg",
        function()
          require("neogen").generate()
        end,
        desc = "Generate comment",
        mode = { "n" },
      },
    },
  },
}
