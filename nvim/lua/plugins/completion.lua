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
    keys = function(_, keys)
      ---@type avante.Config
      local opts =
        require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

      local mappings = {
        {
          opts.mappings.ask,
          function()
            require("avante.api").ask()
          end,
          desc = "avante: ask",
          mode = { "n", "v" },
        },
        {
          opts.mappings.refresh,
          function()
            require("avante.api").refresh()
          end,
          desc = "avante: refresh",
          mode = "v",
        },
        {
          opts.mappings.edit,
          function()
            require("avante.api").edit()
          end,
          desc = "avante: edit",
          mode = { "n", "v" },
        },
        {
          opts.mappings.toggle,
          function()
            require("avante.api").toggle()
          end,
          desc = "avante: toggle",
          mode = { "n", "v" },
        },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      provider = "deepseek",
      auto_suggestions_provider = "deepseek",
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com/v1",
          model = "deepseek-coder",
          -- model = "deepseek-reasoner",
        },
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },

      mappings = {
        ask = "<leader>xa", -- ask
        edit = "<leader>xe", -- edit
        refresh = "<leader>xr", -- refresh
        toggle = "<leader>xo", -- toggle
        suggestion = {
          accept = "<Tab>",
        },
      },

      openai = {
        endpoint = "https://api.deepseek.com/v1",
        model = "deepseek-coder",
      },

      file_selector = {
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
