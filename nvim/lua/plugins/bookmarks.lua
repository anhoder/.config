local bookmarks_util = require("utils.bookmarks")

return {
  {
    "tomasky/bookmarks.nvim",
    opts = {
      save_file = vim.fn.expand("$HOME/.config/.bookmarks"), -- bookmarks save file path
      keywords = {
        ["@t"] = "", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "󰃤", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = "󰎚", -- mark annotation startswith @n ,signs this icon as `Note`
        ["@bug"] = "󰃤", -- mark annotation startswith @f ,signs this icon as `Fix`
      },
      signs = {
        add = { hl = "BookMarksAdd", text = "󰧌", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
        ann = { hl = "BookMarksAnn", text = "󰃀", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
      },
      on_attach = function()
        local bm = require("bookmarks")
        local map = vim.keymap.set
        map("n", "<leader>mm", bm.bookmark_toggle, { desc = "add or remove bookmark at current line" })
        map("n", "<leader>ma", bm.bookmark_ann, { desc = "add or edit mark annotation at current line" })
        map("n", "<leader>m[", bm.bookmark_prev, { desc = "jump to previous mark in local buffer" })
        map("n", "<leader>m]", bm.bookmark_next, { desc = "jump to next mark in local buffer" })
        -- map("n", "<leader>ml", bm.bookmark_list, { desc = "show marked file list in quickfix window" })
        map("n", "<leader>ml", bookmarks_util.pick, { desc = "show marked file list" })
        map({ "n", "i", "s", "v" }, "<D-S-m>", bookmarks_util.pick, { desc = "show marked file list" })
        map("n", "<leader>mc", bm.bookmark_clean, { desc = "clean all marks in local buffer" })
        map("n", "<leader>mx", bm.bookmark_clear_all, { desc = "removes all bookmarks" })
      end,
    },
  },
}
