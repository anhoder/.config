return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      hover = {
        silent = true,
      },
      message = {
        enabled = true,
        view = "popup",
      },
    },
    status = {
      command = {
        has = false,
      },
    },
  },
  init = function()
    -- fix noice lsp message event
    require("noice.lsp.message").event = "lsp"
  end,
}
