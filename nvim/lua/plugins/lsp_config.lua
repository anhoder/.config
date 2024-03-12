local home = vim.fn.expand("$HOME")
local telescope_pickers = require("utils.telescope_pickers")
local keys = require("lazyvim.plugins.lsp.keymaps").get()
local telescope_themes = require("telescope.themes")
local lsputil = require("utils.lsp")

table.insert(keys, {
  "gR",
  function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_references"
    telescope_pickers.prettyLsp(opts)
  end,
  desc = "Goto references",
})

table.insert(keys, {
  "gi",
  function()
    vim.cmd("Glance implementations")
  end,
  desc = "Goto implementations",
})

table.insert(keys, {
  "gY",
  function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_type_definitions"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,
  desc = "Goto type definitions",
})

local keymap_rewrite = {
  ["gr"] = function()
    vim.cmd("Glance references")
  end,

  ["gD"] = function()
    lsputil.definition_handle(function(is_definition)
      local opts = telescope_themes.get_ivy()
      opts["picker"] = "lsp_references"

      if is_definition then
        opts["picker"] = "lsp_definitions"
      end

      telescope_pickers.prettyLsp(opts)
    end)
  end,

  ["gd"] = function()
    lsputil.definition_handle(function(is_definition)
      if is_definition then
        vim.cmd("Glance definitions")
        return
      end
      vim.cmd("Glance references")
    end)
  end,

  ["gI"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_implementations"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,

  ["gy"] = function()
    vim.cmd("Glance type_definitions")
  end,

  -- hover fold
  ["K"] = function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end,
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
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
              analyses = {
                fieldalignment = false,
                ST1000 = false,
                ST1003 = false,
                SA4006 = false,
              },
            },
          },
        },

        -- clang use `bear`
        clangd = {
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },

        --lua
        lua_ls = {
          settings = {
            Lua = {
              codeLens = {
                enable = false,
              },
            },
          },
        },
      },
    },
    init = function()
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

      for i, key in pairs(keys) do
        if keymap_rewrite[key[1]] then
          keys[i][2] = keymap_rewrite[key[1]]
        end
      end
    end,
  },
}
