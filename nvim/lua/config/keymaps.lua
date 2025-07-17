-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("config.keymaps_without_dep")

local map = vim.keymap.set

---@diagnostic disable-next-line: undefined-field
if vim.g.vscode then
  map("n", "gi", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
  return
end

-- local toggleterm = require("toggleterm.terminal")
-- local telescope = require("telescope")
-- local telescope_builtin = require("telescope.builtin")
-- local telescope_themes = require("telescope.themes")
-- local ivy_theme = telescope_themes.get_ivy({ sorting_strategy = "descending" })
local Util = require("lazyvim.util")
local helper = require("utils.helper")
local neotree_manager = require("neo-tree.sources.manager")
local neotree_render = require("neo-tree.ui.renderer")
local grug_far = require("grug-far")
local neotree = require("neo-tree.command")

local lazygit_size = function(percent)
  percent = percent or 1.0
  return { width = math.floor(vim.o.columns * 0.95 * percent), height = math.floor(vim.o.lines * 0.92 * percent) }
end

---@type snacks.terminal.Opts
local terminal_opts = {
  win = {
    style = "terminal",
    position = "float",
    border = "rounded",
    enter = true,
    backdrop = 100,
    fixbuf = true,
    resize = true,
    width = function()
      return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
  },
}

---@param term_name string
local resolve_term_opts = function(term_name)
  return vim.tbl_extend("force", terminal_opts, {
    env = { nvim_term_name = term_name },
    win = {
      wo = {
        winbar = term_name,
      },
    },
  })
end

local term1_opts = resolve_term_opts("term1")
local term2_opts = resolve_term_opts("term2")
local term3_opts = resolve_term_opts("term3")
local musicfox_opts = resolve_term_opts("musicfox")

-- local Terminal = toggleterm.Terminal
-- local terminal_opts = {
--   direction = "float",
--   hidden = false,
--   close_on_exit = false,
--   auto_scroll = false,
--   float_opts = {
--     ---@diagnostic disable-next-line: undefined-field
--     border = vim.g.neovide and "solid" or "curved",
--     width = function()
--       return math.floor(vim.o.columns * 0.8)
--     end,
--     height = function()
--       return math.floor(vim.o.lines * 0.8)
--     end,
--   },
-- }
-- local musicfox = Terminal:new(vim.tbl_extend("force", terminal_opts, {
--   cmd = "musicfox",
--   id = 99,
--   display_name = "musicfox",
-- }))
-- local term0 = Terminal:new({ direction = "horizontal" })
-- local term1 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 1, display_name = "term1" }))
-- local term2 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 2, display_name = "term2" }))
-- local term3 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 3, display_name = "term3" }))

-- n normal, i insert, v visual, s select, c command, t terminal, o operator pending

---@diagnostic disable-next-line: undefined-field
if vim.g.neovide then
  map({ "n", "i", "v", "t" }, "<D-n>", function()
    vim.fn.jobstart("neovide")
  end, { desc = "New neovide instance" })
  map({ "n", "i", "v", "t" }, "<C-D-f>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle neovide fullscreen" })
  map({ "n", "i", "v", "t" }, "<D-S-t>", function()
    vim.g.neovide_transparency = 0.8
    pcall(vim.fn.jobstart, { "killall", "Dock" })
  end, { desc = "Open neovide transparency" })
end

-- Close window
map({ "n", "i", "v", "t" }, "<D-w>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
map({ "n", "i", "v", "t" }, "<Char-0xAA>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" }) -- for wezterm

-- disable macro
map({ "n", "v" }, "q", "<Nop>", { desc = "Disable macro" })

-- disable mark
map({ "n", "v" }, "m", "<Nop>", { desc = "Disable mark" })

-- Format code
map({ "n", "i", "v" }, "<A-f>", vim.lsp.buf.format, { desc = "Format code" })

-- Terminal
-- local hide_all = function()
--   for _, value in ipairs(toggleterm.get_all(false)) do
--     value:close()
--   end
-- end
map({ "i", "n", "v", "s", "t", "o" }, "<D-`>", Snacks.terminal.toggle, { desc = "Open terminal" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-`>", Snacks.terminal.toggle, { desc = "Open terminal" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-1>", function()
  Snacks.terminal.toggle(vim.o.shell, term1_opts)
end, { desc = "Open term1" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-2>", function()
  Snacks.terminal.toggle(vim.o.shell, term2_opts)
end, { desc = "Open term2" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-3>", function()
  Snacks.terminal.toggle(vim.o.shell, term3_opts)
end, { desc = "Open term3" })

-- musicfox
map({ "i", "n", "v", "s", "t", "o" }, "<C-Esc>", function()
  Snacks.terminal.toggle("musicfox", musicfox_opts)
end, { desc = "Run musicfox" })

-- lazygit
map("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazygit_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-g>", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazygit_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-Esc>", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazygit_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  Snacks.lazygit({ size = lazygit_size(), esc_esc = true })
end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  Snacks.lazygit({ args = { "-f", vim.trim(git_path) }, size = lazygit_size(), esc_esc = true })
end, { desc = "Lazygit current file history" })

-- fork
map("n", "<leader>gF", function()
  vim.fn.jobstart("fork " .. Util.root())
end, { desc = "Open fork" })

-- Increase, Decrease Font size
local change_font_size = function(delta)
  return function()
    vim.g.guifontsize = vim.g.guifontsize + delta
    -- local font = string.gsub(vim.g.guifont, " ", "\\ ")
    -- vim.cmd("set guifont=" .. font .. ":h" .. vim.g.guifontsize)
    local font = vim.g.build_guifont(true)
    vim.cmd("set guifont=" .. font)
  end
end
map({ "i", "n", "v", "s", "t", "o" }, "<D-=>", change_font_size(1), { desc = "Increase font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-->", change_font_size(-1), { desc = "Decrease font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-0>", function()
  -- local font = string.gsub(vim.g.guifont, " ", "\\ ")
  -- vim.cmd("set guifont=" .. font .. ":h" .. 16)
  vim.g.guifontsize = vim.g.guifontsize_default
  local font = vim.g.build_guifont(true)
  vim.cmd("set guifont=" .. font)
end, { desc = "Reset font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-=>", change_font_size(1), { desc = "Increase font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-->", change_font_size(-1), { desc = "Decrease font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-0>", function()
  -- local font = string.gsub(vim.g.guifont, " ", "\\ ")
  -- vim.cmd("set guifont=" .. font .. ":h" .. 16)
  vim.g.guifontsize = vim.g.guifontsize_default
  local font = vim.g.build_guifont(true)
  vim.cmd("set guifont=" .. font)
end, { desc = "Reset font size" })

-- telescope
-- map({ "n" }, "<leader>sg", function()
--   fzf_lua_grep.live_grep({
--     rg_glob = {
--       "!vendor/",
--       "!node_modules/",
--     },
--   })
-- telescope_pickers.prettyGrepPicker({
--   picker = "live_grep",
--   options = {
--     glob_pattern = {
--       "!vendor/",
--       "!node_modules/",
--     },
--   },
-- })
-- end, { desc = "Live Grep" })
-- map({ "n" }, "<leader>sG", function()
--   local fs_state = neotree_manager.get_state("filesystem")
--   if neotree_render.tree_is_visible(fs_state) then
--     local dir = get_folder_node(fs_state.tree)
--     if dir then
--       vim.notify("search in " .. dir.path)
--       LazyVim.pick("live_grep", { cwd = dir.path })
--       -- telescope_pickers.prettyGrepPicker({
--       --   picker = "live_grep",
--       --   options = {
--       --     cwd = dir.path,
--       --   },
--       -- })
--       return
--     end
--   end
--   vim.notify("search in " .. vim.fn.getcwd())
--   LazyVim.pick("live_grep", { root = true })
-- end, { desc = "Telescope Live Grep(selected or root dir)" })

-- Find files(root)
-- map({ "n" }, "<leader>ff", function()
--   telescope_pickers.prettyFilesPicker({ picker = "find_files" })
-- end, { desc = "Find files(root)" })
-- map({ "n" }, "<leader><space>", function()
--   telescope_pickers.prettyFilesPicker({ picker = "find_files" })
-- end, { desc = "Find files(root)" })

-- Find files(cwd)
-- map({ "n" }, "<leader>fF", function()
--   telescope_pickers.prettyFilesPicker({ picker = "find_files", options = { cwd = vim.fn.getcwd() } })
-- end, { desc = "Find files(cwd)" })

-- Git files
-- map({ "n" }, "<leader>fg", function()
--   telescope_pickers.prettyFilesPicker({ picker = "git_files" })
-- end, { desc = "Git files" })

-- Open git remote
map({ "n" }, "<leader>go", function()
  Snacks.gitbrowse.open({ what = "branch" })
  -- vim.fn.system("git open")
end, { desc = "Open git remote" })
map({ "n" }, "<leader>gO", function()
  Snacks.gitbrowse.open({ what = "file" })
end, { desc = "Open git remote" })

-- Buffer picker
-- map({ "n" }, "<leader>fb", function()
--
--   telescope_pickers.prettyBuffersPicker()
-- end, { desc = "Buffers" })
-- map({ "n" }, "<leader>bt", function()
--   telescope_pickers.prettyBuffersPicker()
-- end, { desc = "Buffers" })

-- upload to remote
map({ "n", "v", "i" }, "<C-D-u>", function()
  vim.cmd("ARsyncUp")
end, { desc = "Sync up to remote" })
map({ "n", "v", "i" }, "<C-D-d>", function()
  vim.cmd("ARsyncDown")
end, { desc = "Sync down from remote" })

-- open file in finder
map({ "n" }, "<leader>p", function()
  local fs_state = neotree_manager.get_state("filesystem")
  local path = vim.fn.expand("%:p:h")
  if neotree_render.tree_is_visible(fs_state) then
    local node = fs_state.tree:get_node()
    path = node.path
  end
  vim.fn.jobstart("open " .. path)
end, { desc = "Open file in Finder" })

-- open file in vscode
map({ "n" }, "<leader>P", function()
  local fs_state = neotree_manager.get_state("filesystem")
  local path = vim.fn.expand("%")
  if neotree_render.tree_is_visible(fs_state) then
    local node = fs_state.tree:get_node()
    path = node.path
  end
  local _, _, code = vim.fn.jobstart("code " .. path)
  if code == 0 then
    return
  end
  vim.fn.jobstart("code-insiders " .. path)
end, { desc = "Open file in code" })

-- neo-tree keymaps
-- locate cur file in neo-tree
map({ "n", "v", "i", "o", "s" }, "<C-D-/>", function()
  neotree.execute({ reveal = true, toggle = vim.bo.filetype == "neo-tree" })
  -- neotree.execute({ reveal = true, action = "focus" })
end, { desc = "Locate cur file in neo-tree" })
map({ "n", "v", "i", "o", "s" }, "<A-1>", function()
  neotree.execute({ toggle = true })
end, { desc = "Open neotree" })
map({ "n", "v", "i", "o", "s" }, "<A-2>", function()
  neotree.execute({ source = "buffers", toggle = true })
end, { desc = "Open neotree buffers" })
map({ "n", "v", "i", "o", "s" }, "<A-3>", function()
  neotree.execute({ source = "git_status", toggle = true })
end, { desc = "Open neotree git_status" })

-- toggle pin buffer
map({ "n", "v", "i" }, "<D-p>", function()
  vim.cmd("BufferLineTogglePin")
end, { desc = "Pin cur buffer" })

-- copy cur file path
map({ "n" }, "<leader>cp", function()
  local p = helper.get_current_position()
  helper.copy_to_clipboard(p)
  vim.notify(p)
end, { desc = "Copy cur file path" })

-- copy cur file path with line no
map({ "n" }, "<leader>cP", function()
  local p = helper.get_current_position({ with_line = true })
  helper.copy_to_clipboard(p)
  vim.notify(p)
end, { desc = "Copy cur file path with line no" })

-- copy cur branch
map({ "n" }, "<leader>cb", function()
  ---@diagnostic disable-next-line: undefined-field
  local branch = vim.b.gitsigns_head
  helper.copy_to_clipboard(branch)
  vim.notify(branch)
end, { desc = "Copy cur path" })

-- git conflict
map("n", "<leader>ghc", function()
  vim.cmd("Gvdiffsplit!")
end, { desc = "Git Blame", noremap = true })

-- git diffview open
local diffview_opened = false
map({ "i", "n", "v", "s", "t", "o" }, "<A-4>", function()
  if not diffview_opened then
    vim.cmd("DiffviewOpen")
  else
    vim.cmd("DiffviewClose")
  end
  diffview_opened = not diffview_opened
end, { desc = "Git diffview", noremap = true })

-- mouse go tnormalo
map(
  { "n", "i", "v" },
  "<D-LeftMouse>",
  "<LeftMouse><cmd>lua require('utils.lsp').goto_def()<cr>",
  { desc = "Jump to", noremap = true }
)
map(
  { "n", "i", "v" },
  "<RightMouse>",
  "<LeftMouse><cmd>lua require('utils.lsp').hover()<cr>",
  { desc = "Show desc", noremap = true }
)
map(
  { "n", "i", "v" },
  "<2-RightMouse>",
  "<LeftMouse><cmd>lua require('utils.lsp').goto_def()<cr>",
  { desc = "Jump to", noremap = true }
)

-- spectre: search and replace
map({ "n" }, "<D-r>", function()
  grug_far.open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
end, { desc = "Search on current file" })
map({ "n" }, "<leader>sr", function()
  grug_far.open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
end, { desc = "Search on current file" })
map({ "v" }, "<D-r>", function()
  grug_far.with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
end, { desc = "Search on current file" })
map({ "v" }, "<leader>sr", function()
  grug_far.with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
end, { desc = "Search on current file" })
map({ "n" }, "<D-R>", function()
  grug_far.open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search " })
map({ "n" }, "<leader>sR", function()
  grug_far.open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search " })
map({ "v" }, "<D-R>", grug_far.with_visual_selection, { desc = "Search " })
map({ "v" }, "<leader>sR", grug_far.with_visual_selection, { desc = "Search " })
