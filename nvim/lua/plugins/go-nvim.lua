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
    -- "anhoder/go.nvim",
    "ray-x/go.nvim",
    -- enabled = false,
    event = { "VeryLazy", "CmdlineEnter" },
    ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    dependencies = { -- optional packages
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("go").setup({
        lsp_cfg = false,
        icons = false,
        -- build_tags = "wireinject",
        lsp_keymaps = false,
        diagnostic = {
          hdlr = true,
        },
        lsp_inlay_hints = {
          enable = false,
          style = "eol",
          highlight = "LspInlayHint",
        },
        dap_debug_vt = false,
        sign_covered_hl = "GruvboxAqua",
        sign_partial_hl = "GruvboxYellow",
        sign_uncovered_hl = "GruvboxRed",
      })
      local cfg = require("go.lsp").config()
      cfg = vim.tbl_deep_extend("force", cfg, require("utils.lsp").gopls_config())
      require("lspconfig").gopls.setup(cfg)

      -- format and import on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
      vim.keymap.set("n", "<leader>ci", require("go.format").goimport, { desc = "import go module" })
    end,
    build = ':lua require("go.install").update_all_sync()',
  },
}
