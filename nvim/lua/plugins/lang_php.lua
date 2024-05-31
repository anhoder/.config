local home = vim.fn.expand("$HOME")

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
      servers = {
        -- php
        intelephense = {
          capabilities = {
            textDocument = {
              rangeFormatting = true,
              formatting = true,
            },
          },
          single_file_support = true,
          on_attach = function(client, bufnr)
            -- 仅格式化修改内容
            local augroup_id =
              vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
            vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

            local lsp_format_modifications = require("lsp-format-modifications")
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
              group = augroup_id,
              buffer = bufnr,
              callback = function()
                lsp_format_modifications.format_modifications(client, bufnr)
              end,
            })
          end,
          settings = {
            intelephense = {
              environment = {
                includePaths = {
                  home .. "/Desktop/www/yii/",
                  home .. "/.config/phpstorm-stubs/",
                },
              },
            },
            -- The settings only work by putting the licence key in ~/intelephense/licence.txt
            -- licenceKey = "XXXXXXXXXXXXXXX",
          },
          autostart = true,
        },
        -- phpactor = {
        --   single_file_support = true,
        --   filetypes = { "php" },
        --   init_options = {
        --     ["indexer.stub_paths"] = { home .. "/Desktop/www/yii/" },
        --     ["completion_worse.completor.constant.enabled"] = true,
        --     ["language_server.diagnostics_on_update"] = false,
        --     ["language_server.diagnostic_sleep_time"] = 500,
        --   },
        --   autostart = false,
        -- },
      },
    },
  },
}
