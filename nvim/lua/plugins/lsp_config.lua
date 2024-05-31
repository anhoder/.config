local telescope_pickers = require("utils.telescope_pickers")
local telescope_themes = require("telescope.themes")
local lsputil = require("utils.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      single_file_support = true,
      -- inlay_hints = {
      --   enabled = false,
      -- },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = true,
            lineFoldingOnly = true,
          },
        },
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gr", "<cmd>Glance references<cr>", desc = "Goto references" }
      keys[#keys + 1] = {
        "gR",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_references"
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto references",
      }

      keys[#keys + 1] = { "gi", "<cmd>Glance implementations<cr>", desc = "Goto implementations" }
      keys[#keys + 1] = {
        "gI",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_implementations"
          opts["reuse_win"] = true
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto implementations",
      }

      keys[#keys + 1] = { "gy", "<cmd>Glance definitions<cr>", desc = "Goto type definitions" }
      keys[#keys + 1] = {
        "gY",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_type_definitions"
          opts["reuse_win"] = true
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto type definitions",
      }

      keys[#keys + 1] = {
        "gd",
        lsputil.goto_def,
        desc = "Goto definition",
      }
      keys[#keys + 1] = {
        "gD",
        function()
          lsputil.definition_handle(function(is_definition)
            local opts = telescope_themes.get_ivy()
            opts["picker"] = "lsp_references"

            if is_definition then
              opts["picker"] = "lsp_definitions"
            end
            telescope_pickers.prettyLsp(opts)
          end)
        end,
        desc = "Goto definition",
      }

      keys[#keys + 1] = {
        "K",
        lsputil.hover,
        desc = "Hover",
      }

      -- keys[#keys + 1] = { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Saga Code Action" }
      keys[#keys + 1] = { "<leader>co", vim.lsp.codelens.run, desc = "Run CodeLenAct" }
      -- keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Saga Goto next diagnostic" }
      -- keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Saga Goto prev diagnostic" }
      -- keys[#keys + 1] = { "<leader>cs", "<cmd>Lspsaga outline<cr>", desc = "Saga Open outline" }
      -- keys[#keys + 1] = { "<leader>cr", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename" }

      -- local lspconfig = require("lspconfig")
      -- local configs = require("lspconfig.configs")
      --
      -- if not configs.pls then
      --   configs.pls = {
      --     default_config = {
      --       cmd = { "pls" },
      --       root_dir = lspconfig.util.root_pattern(".git"),
      --       filetypes = { "proto" },
      --     },
      --   }
      -- end
      -- lspconfig.pls.setup({})
    end,
  },
}
