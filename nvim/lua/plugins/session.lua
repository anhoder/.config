local persisted_util = require("utils.persisted")

return {
  {
    "olimorris/persisted.nvim",
    -- enabled = false,
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
      { "<D-S-p>", persisted_util.pick, desc = "Select project" },
    },
  },
}
