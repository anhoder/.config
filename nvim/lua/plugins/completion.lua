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
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    enabled = false,
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

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make lua51",
    opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",

      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },

      mappings = {
        suggestion = {
          accept = "<Tab>",
        },
      },

      openai = {
        endpoint = "https://api.deepseek.com/v1",
        model = "deepseek-coder",
      },

      file_selector = {
        --- @alias FileSelectorProvider "native" | "fzf" | "telescope" | string
        provider = "fzf",
        -- Options override for custom providers
        provider_opts = {},
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",

      {
        "grapp-dev/nui-components.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
        },
      },
      {
        "blink.compat",
        lazy = true,
      },
      {
        "saghen/blink.cmp",
        opts = {
          sources = {
            compat = {
              "avante_commands",
              "avante_mentions",
              "avante_files",
            },
            providers = {
              avante_commands = {
                name = "avante_commands",
                module = "blink.compat.source",
                score_offset = 90, -- show at a higher priority than lsp
                opts = {},
              },
              avante_files = {
                name = "avante_commands",
                module = "blink.compat.source",
                score_offset = 100, -- show at a higher priority than lsp
                opts = {},
              },
              avante_mentions = {
                name = "avante_mentions",
                module = "blink.compat.source",
                score_offset = 1000, -- show at a higher priority than lsp
                opts = {},
              },
            },
          },
        },
      },
    },
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
