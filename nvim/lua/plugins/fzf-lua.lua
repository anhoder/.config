return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        keymap = {
          fzf = {
            ["shift-down"] = "next-history",
            ["shift-up"] = "prev-history",
          },
        },
        files = {
          fzf_opts = {
            ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
          },
          cwd_prompt = false,
        },
        grep = {
          fzf_opts = {
            ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
          },
        },
      })
    end,
  },
}
