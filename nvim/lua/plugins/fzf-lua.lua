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

local actions = require("fzf-lua").actions
local helper = require("utils.helper")

local fzf_grep_history = function()
  return vim.fn.stdpath("data") .. "/fzf-grep-" .. helper.path_escape(vim.fn.getcwd())
end
local fzf_files_history = function()
  return vim.fn.stdpath("data") .. "/fzf-files-" .. helper.path_escape(vim.fn.getcwd())
end

return {
  {
    "ibhagwan/fzf-lua",
    optional = true,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        "hide",
        "border-fused",
        keymap = {
          fzf = {
            ["shift-down"] = "next-history",
            ["shift-up"] = "prev-history",
          },
        },
        files = {
          fzf_opts = {
            ["--history"] = vim.fn.stdpath("data") .. "/fzf-files-common",
          },
          cwd_prompt = false,
          git_icons = false,
        },
        grep = {
          fzf_opts = {
            ["--history"] = vim.fn.stdpath("data") .. "/fzf-grep-common",
          },
        },
      })
    end,
    keys = {
      {
        "<leader>sg",
        function()
          require("fzf-lua").live_grep_native({ resume = true, fzf_opts = { ["--history"] = fzf_grep_history() } })
        end,
        desc = "live grep",
      },
      {
        "<leader>sG",
        function()
          local cwd = getSelectedCwd()
          vim.notify("search in " .. cwd)
          require("fzf-lua").live_grep_native({
            cwd = cwd,
            resume = true,
            fzf_opts = { ["--history"] = fzf_grep_history() },
          })
        end,
        desc = "live grep in selected directory",
      },
      {
        "<leader><space>",
        function()
          require("fzf-lua").files({ fzf_opts = { ["--history"] = fzf_files_history() } })
        end,
        desc = "search files",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files({ resume = true, fzf_opts = { ["--history"] = fzf_files_history() } })
        end,
        desc = "search files",
      },
      {
        "<leader>fF",
        function()
          local cwd = getSelectedCwd()
          vim.notify("search file in " .. cwd)
          require("fzf-lua").files({ cwd = cwd, resume = true, fzf_opts = { ["--history"] = fzf_files_history() } })
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
