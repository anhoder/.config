return {
  {
    "ibhagwan/fzf-lua",
    optional = true,
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
    keys = {
      {
        "<leader>sG",
        function()
          local neotree_manager = require("neo-tree.sources.manager")
          local neotree_render = require("neo-tree.ui.renderer")
          local neotree_utils = require("utils.helper")
          local fs_state = neotree_manager.get_state("filesystem")
          if neotree_render.tree_is_visible(fs_state) then
            local dir = neotree_utils.get_folder_node(fs_state.tree)
            if dir then
              vim.notify("search in " .. dir.path)
              vim.cmd("FzfLua live_grep cwd=" .. dir.path)
              -- LazyVim.pick("live_grep", { cwd = dir.path })
              return
            end
          end
          vim.notify("search in " .. vim.fn.getcwd())
          vim.cmd("FzfLua live_grep root=true")
        end,
      },
    },
  },
}
