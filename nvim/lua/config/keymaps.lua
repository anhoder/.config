-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

if vim.g.vscode then
  map("n", "gi", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
  return
end

local toggleterm = require("toggleterm.terminal")
-- local telescope = require("telescope")
-- local telescope_builtin = require("telescope.builtin")
-- local telescope_themes = require("telescope.themes")
-- local ivy_theme = telescope_themes.get_ivy({ sorting_strategy = "descending" })
local Util = require("lazyvim.util")
local neotree_manager = require("neo-tree.sources.manager")
local neotree_render = require("neo-tree.ui.renderer")
-- local telescope_pickers = require("utils.telescope_pickers")
local ufo = require("ufo")
local grug_far = require("grug-far")

local lazyterm_size = function(percent)
  percent = percent or 1.0
  return { width = math.floor(vim.o.columns * 0.95 * percent), height = math.floor(vim.o.lines * 0.92 * percent) }
end
-- local lazyterm1 = function()
--   LazyVim.terminal(nil, {
--     title = "term1",
--     -- cwd = LazyVim.root(),
--     size = lazyterm_size(0.85),
--     env = { TERM_NAME = "term1" },
--     esc_esc = true,
--     border = "solid",
--     title_pos = "left",
--   })
-- end
-- local lazyterm2 = function()
--   LazyVim.terminal(nil, {
--     title = "term2",
--     -- cwd = LazyVim.root(),
--     size = lazyterm_size(0.9),
--     env = { TERM_NAME = "term2" },
--     esc_esc = true,
--     border = "solid",
--     title_pos = "left",
--   })
-- end
-- local lazyterm3 = function()
--   LazyVim.terminal(nil, {
--     title = "term3",
--     -- cwd = LazyVim.root(),
--     size = lazyterm_size(1.0),
--     env = { TERM_NAME = "term3" },
--     esc_esc = true,
--     border = "solid",
--     title_pos = "left",
--   })
-- end
-- local musicfox = function()
--   LazyVim.terminal("musicfox", { size = lazyterm_size(), env = { TERM_NAME = "musicfox" }, esc_esc = true })
-- end

local Terminal = toggleterm.Terminal
local terminal_opts = {
  direction = "float",
  hidden = false,
  close_on_exit = false,
  auto_scroll = false,
  float_opts = {
    border = vim.g.neovide and "solid" or "curved",
    width = function()
      return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
  },
}
local musicfox = Terminal:new(vim.tbl_extend("force", terminal_opts, {
  cmd = "musicfox",
  id = 99,
  display_name = "musicfox",
}))
local term0 = Terminal:new({ direction = "horizontal" })
local term1 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 1, display_name = "term1" }))
local term2 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 2, display_name = "term2" }))
local term3 = Terminal:new(vim.tbl_extend("force", terminal_opts, { id = 3, display_name = "term3" }))

-- n normal, i insert, v visual, s select, c command, t terminal, o operator pending

if vim.g.neovide then
  map({ "n", "i", "v", "t" }, "<D-n>", function()
    vim.fn.jobstart("neovide")
  end, { desc = "New neovide instance" })
  map({ "n", "i", "v", "t" }, "<C-D-f>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle neovide fullscreen" })
end

-- Resize window using <ctrl> arrow keys
map({ "n", "i", "v", "t" }, "<C-D-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "i", "v", "t" }, "<C-D-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "i", "v", "t" }, "<C-D-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "i", "v", "t" }, "<C-D-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move to window using the <ctrl> hjkl keys
map({ "n", "i", "v", "t" }, "<C-A-Left>", "<Esc><Esc><C-w>h", { desc = "Go to left window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Down>", "<Esc><Esc><C-w>j", { desc = "Go to lower window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Up>", "<Esc><Esc><C-w>k", { desc = "Go to upper window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Right>", "<Esc><Esc><C-w>l", { desc = "Go to right window", noremap = true })

-- Close window
map({ "n", "i", "v", "t" }, "<D-w>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
map({ "n", "i", "v", "t" }, "<Char-0xAA>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" }) -- for wezterm

-- Save
map({ "n", "i", "v" }, "<D-s>", function()
  vim.cmd("stopinsert")
  vim.cmd("w")
end, { desc = "Save" })
map({ "n", "i", "v", "s", "c" }, "<D-z>", "<cmd>undo<cr>", { desc = "Undo" })
map({ "n", "i", "v", "s", "c" }, "<D-y>", "<cmd>redo<cr>", { desc = "Redo" })
map({ "n", "i", "v", "s", "c" }, "<D-S-z>", "<cmd>redo<cr>", { desc = "Redo" })

-- Dup one line
map({ "n", "i" }, "<D-d>", "<cmd>LineDuplicate +1<cr>", { desc = "Paste", noremap = true })
map({ "v" }, "<D-d>", "<cmd>VisualDuplicate +1<cr>", { desc = "Paste", noremap = true })

-- Copy, paste, cut
map({ "n", "v" }, "<D-c>", '"+y', { desc = "Copy", noremap = true })
map({ "n", "v" }, "<D-v>", "P", { desc = "Paste", noremap = true })
map({ "t" }, "<D-v>", '<cmd>stopinsert<cr>"+pi', { desc = "Paste", noremap = true })
map({ "n", "v" }, "<D-x>", '"+x', { desc = "Cut", noremap = true })
map({ "c" }, "<D-v>", "<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>", { desc = "Paste", noremap = true })
map({ "i" }, "<D-v>", "<cmd>normal! P<cr><Right>", { desc = "Paste", noremap = true })

-- Delete a word
map({ "i" }, "<C-BS>", "<C-w>", { desc = "Delete word backword", noremap = true })
map({ "n" }, "<C-BS>", '"_cb', { desc = "Delete word backward", noremap = false })
map({ "n" }, "<A-BS>", '"_cw', { desc = "Delete word forward", noremap = false })
map({ "i" }, "<A-BS>", '<Esc>l"_cw', { desc = "Delete word forward", noremap = false })
map({ "i", "n", "v" }, "<D-BS>", '<Esc>"_ciw', { desc = "Delete a whole word", noremap = false })
map({ "i", "n", "v" }, "<D-S-BS>", '<Esc>"_ciw', { desc = "Delete a whole word", noremap = false })

-- Move to beginning/end of line
map({ "n", "v" }, "<D-Left>", "^", { desc = "Beginning of line" })
map({ "n" }, "<D-Right>", "$", { desc = "End of line" })
map({ "v" }, "<D-Right>", "$h", { desc = "End of line" })
map({ "i" }, "<D-Left>", "<Esc>^i", { desc = "Beginning of line" })
map({ "i" }, "<D-Right>", "<Esc>$a", { desc = "End of line" })
map({ "c" }, "<D-Left>", "<C-b>", { desc = "Beginning of line" })
map({ "t" }, "<D-Left>", "<C-a>", { desc = "Beginning of line" })
map({ "c", "t" }, "<D-Right>", "<C-e>", { desc = "End of line" })

-- Move line
map({ "n", "i", "v", "s", "c" }, "<S-D-Up>", "<A-k>", { desc = "move up", remap = true })
map({ "n", "i", "v", "s", "c" }, "<S-D-Down>", "<A-j>", { desc = "move down", remap = true })

-- move to left/right
map({ "n", "v", "i" }, "<A-Left>", "<cmd>normal! z5h<cr>", { desc = "Scroll to left", noremap = true })
map({ "n", "v", "i" }, "<A-Right>", "<cmd>normal! z5l<cr>", { desc = "Scroll to right", noremap = true })

-- Select
map({ "n", "v" }, "<D-S-Left>", "v^", { desc = "Select to beginning of line" })
map({ "i" }, "<D-S-Left>", "<Esc>v^", { desc = "Select to beginning of line" })
map({ "n", "v" }, "<D-S-Right>", "v$h", { desc = "Select to end of line" })
map({ "i" }, "<D-S-Right>", "<Esc>lv$h", { desc = "Select to end of line" })
map({ "n", "i", "v" }, "<D-a>", "<Esc>ggVG", { desc = "Select all" })

-- Format code
map({ "n", "i", "v" }, "<A-f>", vim.lsp.buf.format, { desc = "Format code" })

-- Comment
map({ "i", "n" }, "<D-/>", "<Esc>gcc", { remap = true, desc = "Comment" })
map("v", "<D-/>", "gc", { remap = true, desc = "Comment selection" })

-- Terminal
-- local hide_all = function()
--   for _, value in ipairs(toggleterm.get_all(false)) do
--     value:close()
--   end
-- end
map({ "i", "n", "v", "s", "t", "o" }, "<D-`>", function()
  term0:toggle()
end, { desc = "Open terminal" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-1>", function()
  term1:toggle()
end, { desc = "Open term1" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-2>", function()
  term2:toggle()
end, { desc = "Open term2" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-3>", function()
  term3:toggle()
end, { desc = "Open term3" })

-- musicfox
map({ "i", "n", "v", "s", "t", "o" }, "<C-Esc>", function()
  musicfox:toggle()
end, { desc = "Run musicfox" })

-- lazygit
map("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-g>", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-Esc>", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  Snacks.lazygit({ size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  Snacks.lazygit({ args = { "-f", vim.trim(git_path) }, size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit current file history" })

-- fork
map("n", "<leader>gF", function()
  vim.fn.jobstart("fork " .. Util.root())
end, { desc = "Open fork" })

-- Increase, Decrease Font size
local change_font_size = function(delta)
  return function()
    vim.g.guifontsize = vim.g.guifontsize + delta
    local font = string.gsub(vim.g.guifont, " ", "\\ ")
    vim.cmd("set guifont=" .. font .. ":h" .. vim.g.guifontsize)
  end
end
map({ "i", "n", "v", "s", "t", "o" }, "<D-=>", change_font_size(1), { desc = "Increase font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-->", change_font_size(-1), { desc = "Decrease font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-0>", function()
  local font = string.gsub(vim.g.guifont, " ", "\\ ")
  vim.cmd("set guifont=" .. font .. ":h" .. 15)
end, { desc = "Reset font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-=>", change_font_size(1), { desc = "Increase font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-->", change_font_size(-1), { desc = "Decrease font size" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-0>", function()
  local font = string.gsub(vim.g.guifont, " ", "\\ ")
  vim.cmd("set guifont=" .. font .. ":h" .. 15)
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

-- Document symbols
map({ "i", "n", "v" }, "<D-m>", function()
  require("fzf-lua.providers.lsp").document_symbols()
  -- telescope_builtin.lsp_document_symbols(ivy_theme)
  -- telescope.extensions.aerial.aerial(ivy_theme)
end, { desc = "Document symbols" })

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

-- locate cur file in neo-tree
map({ "n", "v", "i", "o", "s" }, "<C-D-/>", "<cmd>Neotree reveal<cr>", { desc = "Locate cur file in neo-tree" })

-- toggle pin buffer
map({ "n", "v", "i" }, "<D-p>", function()
  vim.cmd("BufferLineTogglePin")
end, { desc = "Pin cur buffer" })

-- disable ScrollWheelLeft, ScrollWheelRight
map({ "n", "v", "i", "s", "c", "o", "t" }, "<ScrollWheelLeft>", "<Nop>", { desc = "Disabled", noremap = true })
map({ "n", "v", "i", "s", "c", "o", "t" }, "<ScrollWheelRight>", "<Nop>", { desc = "Disabled", noremap = true })
map(
  { "n", "v", "i", "s", "c", "o", "t" },
  "<S-ScrollWheelLeft>",
  "<ScrollWheelLeft>",
  { desc = "Disabled", noremap = true }
)
map(
  { "n", "v", "i", "s", "c", "o", "t" },
  "<S-ScrollWheelRight>",
  "<ScrollWheelRight>",
  { desc = "Disabled", noremap = true }
)

-- notify cwd
map({ "n" }, "<leader>cp", function()
  vim.notify(vim.fn.expand("%"))
end, { desc = "Display cur file path" })

-- add quotation
map("v", "'", "\"+xi'<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>'", { desc = "Add single quotation", noremap = true })
map("v", '"', '"+xi"<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>"', { desc = "Add double quotation", noremap = true })
map("s", "'", "''<cmd>norm! h<cr>", { desc = "Avoiding effect", noremap = true })
map("s", '"', '""<cmd>norm! h<cr>', { desc = "Avoiding effect", noremap = true })

-- git blame
map("n", "<leader>ghb", function()
  vim.cmd("Git blame")
end, { desc = "Git Blame", noremap = true })

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

-- ufo fold
map({ "n" }, "zM", ufo.closeAllFolds, { desc = "Close all folds(ufo)", remap = true })
map({ "n" }, "zR", ufo.openAllFolds, { desc = "Close all folds(ufo)", remap = true })

-- window to tab
map({ "n" }, "<leader>w<Tab>", "<C-w>T", { desc = "Break out into a new tab", remap = true })

-- spectre: search and replace
map({ "n" }, "<D-r>", function()
  grug_far.grug_far({ prefills = { flags = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
end, { desc = "Search on current file" })
map({ "n" }, "<leader>sr", function()
  grug_far.grug_far({ prefills = { flags = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
end, { desc = "Search on current file" })
map({ "v" }, "<D-r>", function()
  grug_far.with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
end, { desc = "Search on current file" })
map({ "v" }, "<leader>sr", function()
  grug_far.with_visual_selection({ prefills = { flags = vim.fn.expand("%") } })
end, { desc = "Search on current file" })
map({ "n" }, "<D-R>", function()
  grug_far.grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search " })
map({ "n" }, "<leader>sR", function()
  grug_far.grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search " })
map({ "v" }, "<D-R>", function()
  grug_far.with_visual_selection()
end, { desc = "Search " })
map({ "v" }, "<leader>sR", function()
  grug_far.with_visual_selection()
end, { desc = "Search " })

-- disable neovim internal grr, gra, grn...
map({ "n" }, "grr", "<Nop>", { desc = "Disable grr" })
map({ "n" }, "gra", "<Nop>", { desc = "Disable gra" })
map({ "n" }, "grn", "<Nop>", { desc = "Disable grn" })
