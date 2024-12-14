return {
  {
    "olimorris/persisted.nvim",
    -- dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = false,
    opts = {
      autosave = true,
      should_save = function()
        return vim.g.persisted_loaded_session
      end,
    },
    keys = {
      -- { "<D-S-p>", "<cmd>Telescope persisted<cr>", desc = "Select project" },
      { "<D-S-p>", "<cmd>SessionSelect<cr>", desc = "Select project" },
    },
  },
}
