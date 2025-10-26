local home = vim.fn.expand("$HOME")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      single_file_support = true,
      -- inlay_hints = {
      --   enabled = false,
      -- },
      servers = {
        -- php
        intelephense = {
          capabilities = {
            textDocument = {
              rangeFormatting = true,
              formatting = true,
              foldingRange = {
                dynamicRegistration = true,
                lineFoldingOnly = true,
              },
            },
          },
          single_file_support = true,
          on_attach = function(client, bufnr)
            -- 仅格式化修改内容
            -- local augroup_id =
            --   vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
            -- vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })
            --
            -- local lsp_format_modifications = require("lsp-format-modifications")
            -- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            --   group = augroup_id,
            --   buffer = bufnr,
            --   callback = function()
            --     lsp_format_modifications.format_modifications(client, bufnr)
            --   end,
            -- })
          end,
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.0",
                includePaths = {
                  home .. "/Desktop/www/yii/",
                },
              },
            },
            -- NOTE:The settings only work by putting the licence key in ~/intelephense/licence.txt
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
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "anhoder/neotest-phpunit",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-phpunit"] = {
        require("neotest-phpunit")({
          filter_dirs = { ".git", "node_modules", "vendor" },
          root_files = { "composer.json", "phpunit.xml", ".gitignore" },
          phpunit_cmd = function()
            if vim.fn.filereadable(home .. "/Desktop/www/tools/vendor/phpunit/phpunit/phpunit") == 1 then
              return home .. "/Desktop/www/tools/vendor/phpunit/phpunit/phpunit"
            end
            return "vendor/bin/phpunit"
          end,
          args = function()
            if vim.fn.filereadable(home .. "/Desktop/www/tools/vendor/phpunit/phpunit/phpunit") == 1 then
              local root = require("lazyvim.util").root()
              return {
                "--bootstrap",
                root .. "/protected/tests/bootstrap.php",
                "--configuration",
                root .. "/protected/tests/phpunit.xml",
              }
            end
            return {}
          end,
          env = {
            XDEBUG_SESSION = 1,
          },
          dap = {
            log = true,
            type = "php",
            request = "launch",
            name = "Listen for XDebug",
            port = 9903,
            stopOnEntry = false,
            xdebugSettings = {
              max_children = 512,
              max_data = 0,
              max_depth = 4,
            },
            breakpoints = {
              exception = {
                Notice = false,
                Warning = false,
                Error = false,
                Exception = false,
                ["*"] = false,
              },
            },
          },
        }),
      }
    end,
  },
}
