return {
  {
    "olimorris/persisted.nvim",
    event = { "VeryLazy", "CmdlineEnter" },
    opts = {
      autosave = true,
      should_autosave = function()
        return vim.g.persisted_loaded_session
      end,
    },
  },
}
