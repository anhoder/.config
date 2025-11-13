-- local telescope_pickers = require("utils.telescope_pickers")
-- local telescope_themes = require("telescope.themes")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      single_file_support = true,
      -- inlay_hints = {
      --   enabled = false,
      -- },

      servers = {
        ["*"] = {
          keys = {
            { "gr", "<cmd>Glance references<cr>", desc = "Goto references" },
            { "gi", "<cmd>Glance implementations<cr>", desc = "Goto implementations" },
            { "gy", "<cmd>Glance definitions<cr>", desc = "Goto type definitions" },
            { "gd", require("utils.lsp").goto_def, desc = "Goto definition" },
            { "K", require("utils.lsp").hover, desc = "Hover" },
            { "<leader>co", vim.lsp.codelens.run, desc = "Run CodeLenAct" },
          },
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = true,
                lineFoldingOnly = true,
              },
            },
          },
        },
      },
    },
  },
}
