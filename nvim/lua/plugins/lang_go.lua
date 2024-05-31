local lazyutil = require("utils.lazyvim")

if not lazyutil.check_extra_enabled("lazyvim.plugins.extras.lang.go") then
  return {}
end

-- if has >=2 adapter, unexpected exceptions from neotest may occur
local enable_e2e_test = false

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- golang
        gopls = require("utils.lsp").gopls_config(),
      },
    },
  },
  {
    "fatih/vim-go",
    enabled = false,
    config = function()
      vim.cmd("hi! link goCoverageCovered CoverageCovered")
      vim.cmd("hi! link goCoverageUncover CoverageUncovered")
    end,
  },
  {
    -- "anhoder/go.nvim",
    "ray-x/go.nvim",
    -- enabled = false,
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
        sign_covered_hl = "CoverageCovered",
        sign_partial_hl = "CoveragePartial",
        sign_uncovered_hl = "CoverageUncovered",
      })
      local cfg = require("go.lsp").config()
      cfg = vim.tbl_deep_extend("force", cfg, require("utils.lsp").gopls_config())
      require("lspconfig").gopls.setup(cfg)

      -- format and import on save
      -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "go",
      --   callback = function()
      --     -- require("go.format").goimport()
      --   end,
      --   group = format_sync_grp,
      -- })
      vim.keymap.set("n", "<leader>ci", require("go.format").goimport, { desc = "Import go module" })
      vim.keymap.set("n", "<leader>tc", "<cmd>GoCoverage -p<cr>", { desc = "Run converage package" })
    end,
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      {
        "anhoder/nvim-ginkgo",
        ft = { "go" },
        cond = enable_e2e_test,
        config = function()
          vim.keymap.set({ "n" }, "<leader>tr", function()
            local path = vim.fn.expand("%:p:h")
            require("neotest").run.run({ adapter = "nvim-ginkgo:" .. require("nvim-ginkgo").root(path) })
          end, { desc = "Run Nearest(ginkgo)" })
          return true
        end,
      },
      {
        "nvim-neotest/neotest-go",
        optional = true,
        cond = not enable_e2e_test,
      },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      if enable_e2e_test then
        vim.list_extend(opts.adapters, {
          require("nvim-ginkgo"),
        })
        opts.adapters["neotest-go"] = nil
      else
        opts.adapters["neotest-go"] = {
          experimental = {
            test_table = true,
          },
        }
      end
    end,
  },
}
