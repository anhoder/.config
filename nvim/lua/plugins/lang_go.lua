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
        build_tags = "wireinject",
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
    dependencies = {
      "anhoder/nvim-ginkgo",
      "nvim-neotest/neotest-go",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("nvim-ginkgo"),
      })
      opts.adapters["neotest-go"] = {
        experimental = {
          test_table = true,
        },
      }
    end,
    init = function()
      local last_filetype = ""
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*",
        callback = function()
          local cur_filetype = vim.o.filetype

          if cur_filetype == "go" then
            if last_filetype == "go" then
              last_filetype = cur_filetype
              return
            end

            last_filetype = cur_filetype

            local path = vim.fn.expand("%:p:h")
            vim.keymap.del({ "n" }, "<leader>tr")
            vim.keymap.set({ "n" }, "<leader>tr", function()
              require("neotest").run.run({
                adapter = "neotest-go:" .. require("neotest-go").root(path),
              })
            end, { desc = "Run Nearest(neotest-go)" })
            vim.keymap.set({ "n" }, "<leader>tR", function()
              require("neotest").run.run({ adapter = "nvim-ginkgo:" .. require("nvim-ginkgo").root(path) })
            end, { desc = "Run Nearest(ginkgo)" })

            return
          end

          if last_filetype ~= "go" then
            last_filetype = cur_filetype
            return
          end

          last_filetype = cur_filetype

          vim.keymap.del({ "n" }, "<leader>tr")
          vim.keymap.del({ "n" }, "<leader>tR")
          vim.keymap.set({ "n" }, "<leader>tr", function()
            require("neotest").run.run()
          end, { desc = "Run Nearest" })
        end,
      })
    end,
  },
}
