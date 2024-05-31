local lazyutil = require("utils.lazyvim")

if not lazyutil.check_extra_enabled("lazyvim.plugins.extras.lang.clangd") then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- clang use `bear`
        clangd = {
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },
    },
  },
}
