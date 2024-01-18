return {
  {
    "mason.nvim",
  },
  {
    "mason-lspconfig.nvim",
  },
  {
    "anhoder/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("go").setup({
        lsp_cfg = false,
        icons = false,
        build_tags = "wireinject",
        lsp_keymaps = false,
        diagnostic = {
          hdlr = true,
        },
      })
      local cfg = require("go.lsp").config()
      if cfg then
        cfg.settings.gopls.analyses = {
          ST1000 = false,
          ST1003 = false,
          SA4006 = false,
        }
      end
      require("lspconfig").gopls.setup(cfg)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
