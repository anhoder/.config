-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

if vim.g.vscode then
  map("n", "gi", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
  return
end

local toggleterm = require("toggleterm.terminal")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local ivy_theme = telescope_themes.get_ivy({ sorting_strategy = "descending" })
local Util = require("lazyvim.util")
local neotree_manager = require("neo-tree.sources.manager")
local neotree_render = require("neo-tree.ui.renderer")
local telescope_pickers = require("utils.telescope_pickers")
local ufo = require("ufo")
local spectre = require("spectre")
local daputil = require("utils.dap")

local close_buf = function()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end

local lazyterm_size = function()
  return { width = math.floor(vim.o.columns * 0.95), height = math.floor(vim.o.lines * 0.92) }
end
local lazyterm1 = function()
  LazyVim.terminal(
    nil,
    { title = "term1", cwd = LazyVim.root(), size = lazyterm_size(), env = { TERM_NAME = "term1" }, esc_esc = true }
  )
end
local lazyterm2 = function()
  LazyVim.terminal(
    nil,
    { title = "term2", cwd = LazyVim.root(), size = lazyterm_size(), env = { TERM_NAME = "term2" }, esc_esc = true }
  )
end
local lazyterm3 = function()
  LazyVim.terminal(
    nil,
    { title = "term3", cwd = LazyVim.root(), size = lazyterm_size(), env = { TERM_NAME = "term3" }, esc_esc = true }
  )
end
local musicfox = function()
  LazyVim.terminal("musicfox", { size = lazyterm_size(), env = { TERM_NAME = "musicfox" }, esc_esc = true })
end

local Terminal = toggleterm.Terminal
-- local float_opts = {
--   border = "curved",
--   width = function()
--     return math.floor(vim.o.columns * 0.95)
--   end,
--   height = function()
--     return math.floor(vim.o.lines * 0.90)
--   end,
-- }
local term0 = Terminal:new({ direction = "horizontal" })
local function get_folder_node(tree, node)
  if not tree then
    return nil
  end
  if not node then
    node = tree:get_node()
  end
  if node.type == "directory" then
    return node
  end
  return get_folder_node(tree, tree:get_node(node:get_parent_id()))
end

-- n normal, i insert, v visual, s select, c command, t terminal, o operator pending

if vim.g.neovide then
  map({ "n", "i", "v", "t" }, "<D-n>", function()
    os.execute("neovide")
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
map({ "n", "i", "v", "t" }, "<D-w>", close_buf, { desc = "Close buffer" })

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
map({ "i", "c" }, "<D-v>", "<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>", { desc = "Paste", noremap = true })

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
map({ "i", "n" }, "<D-/>", function()
  return "<Esc>" .. MiniComment.operator() .. "_"
end, { expr = true, desc = "Comment" })
map("v", "<D-/>", "gc", { remap = true, desc = "Comment selection" })

-- Terminal
-- local hide_all = function()
--   for _, value in ipairs(toggleterm.get_all(false)) do
--     value:close()
--   end
-- end
map({ "i", "n", "v", "s", "t", "o" }, "<D-`>", function()
  if term0:is_open() then
    term0:toggle()
    return
  end
  daputil.dapui_close() -- close dapui
  -- hide_all()
  term0:toggle()
end, { desc = "Open terminal" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-1>", lazyterm1, { desc = "Open term1" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-2>", lazyterm2, { desc = "Open term2" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-3>", lazyterm3, { desc = "Open term3" })

-- musicfox
map("n", "<leader>mf", musicfox, { desc = "Run musicfox" })
map({ "i", "n", "v", "s", "t", "o" }, "<C-Esc>", musicfox, { desc = "Run musicfox" })

-- lazygit
map("n", "<leader>gg", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-g>", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map({ "i", "n", "v", "s", "t", "o" }, "<D-Esc>", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git(), size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  LazyVim.lazygit({ size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({ args = { "-f", vim.trim(git_path) }, size = lazyterm_size(), esc_esc = true })
end, { desc = "Lazygit current file history" })

-- fork
map("n", "<leader>gF", function()
  os.execute("fork " .. Util.root())
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
map({ "n" }, "<leader>sg", function()
  telescope_pickers.prettyGrepPicker({
    picker = "live_grep",
    options = {
      glob_pattern = {
        "!vendor/",
        "!node_modules/",
      },
    },
  })
end, { desc = "Telescope Live Grep(ignore vendor/node_modules...)" })
map({ "n" }, "<leader>sG", function()
  local fs_state = neotree_manager.get_state("filesystem")
  if neotree_render.tree_is_visible(fs_state) then
    local dir = get_folder_node(fs_state.tree)
    if dir then
      vim.notify("search in " .. dir.path)
      telescope_pickers.prettyGrepPicker({
        picker = "live_grep",
        options = {
          cwd = dir.path,
        },
      })
      return
    end
  end
  vim.notify("search in " .. vim.fn.getcwd())
  telescope_pickers.prettyGrepPicker({ picker = "live_grep" })
end, { desc = "Telescope Live Grep(selected or root dir)" })

-- Document symbols
map({ "i", "n", "v" }, "<D-m>", function()
  telescope_builtin.lsp_document_symbols(ivy_theme)
  -- telescope.extensions.aerial.aerial(ivy_theme)
  -- vim.cmd("Lspsaga outline")
end, { desc = "Document symbols" })
map({ "i", "n", "v" }, "<D-S-m>", function()
  telescope_pickers.prettyDocumentSymbols({ symbols = require("lazyvim.config").get_kind_filter() })
  telescope_builtin.lsp_document_symbols(ivy_theme)
  telescope.extensions.aerial.aerial(ivy_theme)
  -- vim.cmd("Lspsaga outline")
end, { desc = "Document symbols" })

-- Find files(root)
map({ "n" }, "<leader>ff", function()
  telescope_pickers.prettyFilesPicker({ picker = "find_files" })
end, { desc = "Find files(root)" })
map({ "n" }, "<leader><space>", function()
  telescope_pickers.prettyFilesPicker({ picker = "find_files" })
end, { desc = "Find files(root)" })

-- Find files(cwd)
map({ "n" }, "<leader>fF", function()
  telescope_pickers.prettyFilesPicker({ picker = "find_files", options = { cwd = vim.fn.getcwd() } })
end, { desc = "Find files(cwd)" })

-- Git files
map({ "n" }, "<leader>fg", function()
  telescope_pickers.prettyFilesPicker({ picker = "git_files" })
end, { desc = "Git files" })

-- Open git remote
map({ "n" }, "<leader>go", function()
  vim.fn.system("git open")
end, { desc = "Open git remote" })

-- Buffer picker
map({ "n" }, "<leader>fb", function()
  telescope_pickers.prettyBuffersPicker()
end, { desc = "Buffers" })
map({ "n" }, "<leader>bt", function()
  telescope_pickers.prettyBuffersPicker()
end, { desc = "Buffers" })

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
  os.execute("open " .. path)
end, { desc = "Open file in Finder" })

-- open file in vscode
map({ "n" }, "<leader>P", function()
  local fs_state = neotree_manager.get_state("filesystem")
  local path = vim.fn.expand("%")
  if neotree_render.tree_is_visible(fs_state) then
    local node = fs_state.tree:get_node()
    path = node.path
  end
  local _, _, code = os.execute("code " .. path)
  if code == 0 then
    return
  end
  os.execute("code-insiders " .. path)
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
map({ "n", "v" }, "<leader>sr", function()
  spectre.open_file_search()
end, { desc = "Search on current file" })
map({ "n", "v" }, "<leader>sR", function()
  spectre.open_visual()
end, { desc = "Search " })
