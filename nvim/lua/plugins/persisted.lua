return {
  "anhoder/persisted.nvim",
  event = { "VeryLazy", "CmdlineEnter" },
  opts = {
    autosave = true,
    should_autosave = function()
      if not vim.g.persisted_loaded_session then
        return false
      end
      return true
    end,
  },
}
