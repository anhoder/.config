return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- lua
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
  },
}
