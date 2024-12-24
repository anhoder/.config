local getSelectedCwd = function()
  local neotree_manager = require("neo-tree.sources.manager")
  local neotree_render = require("neo-tree.ui.renderer")
  local neotree_utils = require("utils.helper")
  local fs_state = neotree_manager.get_state("filesystem")
  if neotree_render.tree_is_visible(fs_state) then
    local dir = neotree_utils.get_folder_node(fs_state.tree)
    if dir then
      return dir.path
    end
  end
  return vim.fn.getcwd()
end

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
          local cwd = getSelectedCwd()
          vim.notify("search in " .. cwd)
          require("fzf-lua").live_grep({ cwd = cwd })
        end,
        desc = "search in selected directory",
      },
      {
        "<leader>fF",
        function()
          local cwd = getSelectedCwd()
          vim.notify("search file in " .. cwd)
          require("fzf-lua").files({ cwd = cwd })
        end,
        desc = "search file in selected directory",
      },
      {
        "<leader>ss",
        function()
          require("fzf-lua").resume()
        end,
        desc = "restore last fzf search",
      },
    },
  },
}
