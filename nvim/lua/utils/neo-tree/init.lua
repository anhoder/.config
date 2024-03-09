local telescope = require("utils.telescope")
local icons = require("utils.icons")

local config = {
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = telescope.borderchars("rounded", "tl-t-tr-r-br-b-bl-l"),
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "document_symbols",
    "diagnostics",
  },
  source_selector = {
    winbar = true, -- toggle to show selector on winbar
    content_layout = "center",
    tabs_layout = "equal",
    show_separator_on_edge = true,
    sources = {
      { source = "filesystem", display_name = "󰉓" },
      { source = "buffers", display_name = "󰈙" },
      { source = "git_status", display_name = "" },
      { source = "document_symbols", display_name = "" },
      { source = "diagnostics", display_name = "󰒡" },
    },
  },
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      -- expander config, needed for nesting files
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = " ",
    },
    modified = { symbol = "" },
    git_status = { symbols = icons.git },
    diagnostics = { symbols = icons.diagnostics },
  },
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true } },
    },
  },
  filesystem = {
    filtered_items = {
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        ".git",
        ".idea",
        -- ".vscode",
        ".fleet",
        ".DS_Store",
      },
      never_show = {},
    },
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
      group_empty_dirs = false,
    }, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = false, -- when true, empty folders will be grouped together
  },
  async_directory_scan = "always",
}

config.filesystem.components = require("utils.neo-tree.sources.filesystem.components")
local function hideCursor()
  vim.cmd([[
    setlocal guicursor=n:block-Cursor
    hi Cursor blend=100
    hi CursorLine guibg=#4c4846
  ]])
end
local function showCursor()
  vim.cmd([[
    setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    hi Cursor blend=0
    hi CursorLine guibg=#3c3836
  ]])
end

local neotree_group = vim.api.nvim_create_augroup("neo-tree_hide_cursor", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertEnter" }, {
      group = neotree_group,
      callback = function()
        local fire = vim.bo.filetype == "neo-tree" and hideCursor or showCursor
        fire()
      end,
    })
    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
      group = neotree_group,
      callback = function()
        showCursor()
      end,
    })
  end,
})

return config
