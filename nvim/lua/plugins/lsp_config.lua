local home = vim.fn.expand("$HOME")
local telescope_pickers = require("config.telescope_pickers")
local keys = require("lazyvim.plugins.lsp.keymaps").get()
local telescope_themes = require("telescope.themes")
local keymap_rewrite = {
  ["gr"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_references"
    telescope_pickers.prettyLsp(opts)
  end,

  ["gd"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_definitions"
    telescope_pickers.prettyLsp(opts)
  end,

  ["gI"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_implementations"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,

  ["gy"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_type_definitions"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- php
        intelephense = {
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
          },
          autostart = true,
        },
        phpactor = {
          single_file_support = true,
          filetypes = { "php" },
          init_options = {
            ["indexer.stub_paths"] = { home .. "/Desktop/www/yii/" },
            ["completion_worse.completor.constant.enabled"] = true,
            ["language_server.diagnostics_on_update"] = false,
            ["language_server.diagnostic_sleep_time"] = 500,
          },
          autostart = false,
        },

        -- golang
        gopls = {
          single_file_support = true,
          settings = {
            gopls = {
              buildFlags = { "-tags=wireinject" },
            },
          },
        },

        -- clang
        clangd = {
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        },
      },
    },
    init = function()
      for i, key in pairs(keys) do
        if keymap_rewrite[key[1]] then
          keys[i][2] = keymap_rewrite[key[1]]
        end
      end
    end,
  },
}
