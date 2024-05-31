local lazyutil = require("utils.lazyvim")

if not lazyutil.check_extra_enabled("lazyvim.plugins.extras.lang.java") then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- java
        jdtls = {
          settings = {
            java = {
              referencesCodeLens = {
                enabled = false,
              },
              implementationsCodeLens = {
                enabled = false,
              },
            },
          },
        },
      },
    },
  },
}
