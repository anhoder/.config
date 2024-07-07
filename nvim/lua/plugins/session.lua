return {
  {
    "olimorris/persisted.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = { "VeryLazy", "CmdlineEnter" },
    opts = {
      autosave = true,
      should_autosave = function()
        return vim.g.persisted_loaded_session
      end,
    },
    keys = {
      { "<D-S-p>", "<cmd>Telescope persisted<cr>", desc = "Select project" },
    },
  },
}
