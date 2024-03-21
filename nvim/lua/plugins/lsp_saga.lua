return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = true,
      },
      callhierarchy = {
        keys = {
          vsplit = "v",
          toggle_or_open = { "<CR>", "o", "<2-LeftMouse>" },
          quit = { "q", "<ESC>" },
        },
      },
      code_action = {
        extend_gitsigns = false,
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
      diagnostic = {
        extend_relatedInformation = true,
        keys = {
          quit = { "q", "<ESC>" },
          quit_in_show = { "q", "<ESC>" },
        },
      },
      finder = {
        keys = {
          vsplit = "v",
          toggle_or_open = { "<CR>", "o", "<2-LeftMouse>" },
          quit = { "q", "<ESC>" },
        },
      },
      implement = {
        enable = true,
        sign = true,
        virtual_text = true,
      },
      hover = {
        -- max_width = 0.8,
        -- max_height = 0.5,
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        keys = {
          toggle_or_jump = { "<CR>", "o", "<2-LeftMouse>" },
          jump = { "<CR>", "e" },
          quit = { "q", "<ESC>" },
        },
        close_after_jump = true,
        auto_preview = false,
        layout = "float",
      },
      rename = {
        auto_save = true,
        keys = {
          quit = { "<ESC>" },
        },
      },
      beacon = {
        enable = false,
      },
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      ui = {
        border = "single",
        -- title = true,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
