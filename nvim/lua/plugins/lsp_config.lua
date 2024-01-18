local home = vim.fn.expand("$HOME")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          single_file_support = true,
          settings = {
            intelephense = {
              environment = {
                includePaths = { home .. "/Desktop/www/yii/" },
              },
            },
          },
          autostart = true,
        },
        phpactor = {
          single_file_support = true,
          filetypes = { "php" },
          init_options = {
            -- ["language_server.diagnostics_on_open"] = false,
            -- ["language_server.diagnostics_on_save"] = false,
            -- ["language_server.diagnostics_on_update"] = false,
            ["language_server_worse_reflection.inlay_hints.enable"] = true,
            ["language_server_worse_reflection.inlay_hints.types"] = true,
            ["language_server_worse_reflection.inlay_hints.params"] = true,
          },
          autostart = false,
        },
        gopls = {
          single_file_support = true,
          settings = {
            gopls = {
              buildFlags = { "-tags=wireinject" },
            },
          },
        },
      },
    },
  },
}
