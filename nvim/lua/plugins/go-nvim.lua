return {
  {
    "fatih/vim-go",
    enabled = false,
    config = function()
      vim.cmd("hi goCoverageCovered ctermfg=0 ctermbg=0 guifg=0 guibg=#1e500c")
      vim.cmd("hi goCoverageUncover ctermfg=0 ctermbg=0 guifg=0 guibg=#590602")
    end,
  },
  {
    "anhoder/go.nvim",
    -- "ray-x/go.nvim",
    -- enabled = false,
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
          fieldalignment = false,
          ST1000 = false,
          ST1003 = false,
          SA4006 = false,
        }
        cfg.settings.gopls.buildFlags = { "-tags=wireinject" }
      end
      require("lspconfig").gopls.setup(cfg)
      vim.cmd("hi! link goCoverageCovered GruvboxAqua")
      vim.cmd("hi! link goCoveragePartial GruvboxYellow")
      vim.cmd("hi! link goCoverageUncovered GruvboxRed")
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
