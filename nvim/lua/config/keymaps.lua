-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  return
end

local map = vim.keymap.set
local toggleterm = require("toggleterm.terminal")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local ivy_theme = telescope_themes.get_ivy()
local Util = require("lazyvim.util")
local neotree_manager = require("neo-tree.sources.manager")
local neotree_render = require("neo-tree.ui.renderer")
local state = require("hbac.state")
local telescope_pickers = require("config.telescope_pickers")

local Terminal = toggleterm.Terminal
local float_opts = {
  border = "curved",
  width = function()
    return math.floor(vim.o.columns * 0.95)
  end,
  height = function()
    return math.floor(vim.o.lines * 0.95)
  end,
}
local term0 = Terminal:new({ display_name = "term0", direction = "horizontal" })
local term1 = Terminal:new({ display_name = "term1", direction = "float", float_opts = float_opts })
local term2 = Terminal:new({ display_name = "term2", direction = "float", float_opts = float_opts })
local term3 = Terminal:new({ display_name = "term3", direction = "float", float_opts = float_opts })
local musicfox = Terminal:new({
  cmd = "musicfox",
  display_name = "musicfox",
  hidden = true,
  direction = "float",
  float_opts = float_opts,
})
local lazygit = Terminal:new({
  cmd = "lazygit",
  display_name = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = float_opts,
})
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

map({ "n", "i", "v", "t" }, "<C-D-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "i", "v", "t" }, "<C-D-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "i", "v", "t" }, "<C-D-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "i", "v", "t" }, "<C-D-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move to window using the <ctrl> hjkl keys
map({ "n", "i", "v", "t" }, "<C-A-Left>", "<Esc><Esc><C-w>h", { desc = "Go to left window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Down>", "<Esc><Esc><C-w>j", { desc = "Go to lower window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Up>", "<Esc><Esc><C-w>k", { desc = "Go to upper window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-Right>", "<Esc><Esc><C-w>l", { desc = "Go to right window", noremap = true })

map({ "n", "i", "v", "t" }, "<C-A-S-Left>", "<Esc><C-w>h", { desc = "Go to left window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-S-Down>", "<Esc><C-w>j", { desc = "Go to lower window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-S-Up>", "<Esc><C-w>k", { desc = "Go to upper window", noremap = true })
map({ "n", "i", "v", "t" }, "<C-A-S-Right>", "<Esc><C-w>l", { desc = "Go to right window", noremap = true })

-- Close window
map({ "n", "i", "v", "t" }, "<D-w>", function()
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
end, { desc = "Close buffer" })

-- Save
map({ "n", "i", "v" }, "<D-s>", "<cmd>w<cr><Esc>", { desc = "Save" })
map({ "n", "i", "v", "s", "c" }, "<D-z>", "<cmd>undo<cr>", { desc = "Undo" })
map({ "n", "i", "v", "s", "c" }, "<D-y>", "<cmd>redo<cr>", { desc = "Redo" })

-- Dup one line
map({ "n", "v" }, "<D-d>", "<cmd>normal yyp<cr>", { desc = "Paste", noremap = true })
map({ "i" }, "<D-d>", "<cmd>normal yypi<cr>", { desc = "Paste", noremap = true })

-- Copy, paste, cut
map({ "n", "v" }, "<D-c>", '"+y', { desc = "Copy", noremap = true })
map({ "n", "v" }, "<D-v>", '"+pgvy', { desc = "Paste", noremap = true })
map({ "t" }, "<D-v>", '<cmd>stopinsert<cr>"+pi', { desc = "Paste", noremap = true })
map({ "n", "v" }, "<D-x>", '"+x', { desc = "Cut", noremap = true })
map({ "i", "c" }, "<D-v>", "<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>", { desc = "Paste", noremap = true })

map({ "n", "v" }, "<D-S-c>", '"+y', { desc = "Copy", noremap = true })
map({ "n", "v" }, "<D-S-v>", '"+pgvy', { desc = "Paste", noremap = true })
map({ "t" }, "<D-S-v>", '<cmd>stopinsert<cr>"+pi', { desc = "Paste", noremap = true })
map({ "n", "v" }, "<D-S-x>", '"+x', { desc = "Cut", noremap = true })
map({ "i", "c" }, "<D-S-v>", "<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>", { desc = "Paste", noremap = true })

-- Delete a word
map({ "i" }, "<D-BS>", "<C-w>", { desc = "Delete word", noremap = true })
map({ "n" }, "<D-BS>", '"_cb', { desc = "Delete word", noremap = false })
map({ "i", "n" }, "<D-S-BS>", '<Esc>"_ciw', { desc = "Delete a whole word", noremap = false })

-- Move to beginning/end of line
map({ "n", "v" }, "<D-Left>", "^", { desc = "Beginning of line" })
map({ "n" }, "<D-Right>", "$", { desc = "End of line" })
map({ "v" }, "<D-Right>", "$h", { desc = "End of line" })
map({ "i" }, "<D-Left>", "<Esc>^i", { desc = "Beginning of line" })
map({ "i" }, "<D-Right>", "<Esc>$a", { desc = "End of line" })

-- move to left/right
map({ "n", "v", "i" }, "<A-Left>", "<ScrollWheelLeft>", { desc = "Scroll to left", noremap = true })
map({ "n", "v", "i" }, "<A-Right>", "<ScrollWheelRight>", { desc = "Scroll to right", noremap = true })

-- Select
map({ "n", "i", "v" }, "<D-S-Left>", "<Esc>v^", { desc = "Select to beginning of line" })
map({ "n", "i", "v" }, "<D-S-Right>", "<Esc>v$h", { desc = "Select to end of line" })
map({ "n", "i", "v" }, "<D-a>", "<Esc>ggVG", { desc = "Select all" })

-- Comment
map({ "i", "n" }, "<D-/>", function()
  return "<Esc>" .. MiniComment.operator() .. "_"
end, { expr = true, desc = "Comment" })
map("v", "<D-/>", [[:<c-u>lua MiniComment.operator('visual')<cr>]], { desc = "Comment selection" })

-- Terminal
local hide_all = function()
  for _, value in ipairs(toggleterm.get_all(false)) do
    value:close()
  end
end
map({ "i", "n", "v", "t" }, "<D-`>", function()
  vim.cmd("stopinsert")
  if term0:is_open() then
    term0:toggle()
    return
  end
  hide_all()
  term0:toggle()
  term0:set_mode(toggleterm.mode.INSERT)
end, { desc = "Open terminal" })
map({ "i", "n", "v", "t" }, "<D-1>", function()
  vim.cmd("stopinsert")
  term1:toggle()
  if term1:is_open() then
    term1:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 1" })
map({ "i", "n", "v", "t" }, "<D-2>", function()
  vim.cmd("stopinsert")
  term2:toggle()
  if term2:is_open() then
    term2:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 2" })
map({ "i", "n", "v", "t" }, "<D-3>", function()
  vim.cmd("stopinsert")
  term3:toggle()
  if term3:is_open() then
    term3:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 3" })
map({ "i", "n", "v", "t" }, "<D-S-1>", function()
  vim.cmd("stopinsert")
  term1:toggle()
  if term1:is_open() then
    term1:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 1" })
map({ "i", "n", "v", "t" }, "<D-S-2>", function()
  vim.cmd("stopinsert")
  term2:toggle()
  if term2:is_open() then
    term2:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 2" })
map({ "i", "n", "v", "t" }, "<D-S-3>", function()
  vim.cmd("stopinsert")
  term3:toggle()
  if term3:is_open() then
    term3:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Open terminal 3" })

-- musicfox
map("n", "<leader>mf", function()
  musicfox:toggle()
  if musicfox:is_open() then
    musicfox:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Run musicfox" })

map({ "i", "n", "v", "t" }, "<D-Esc>", function()
  vim.cmd("stopinsert")
  musicfox:toggle()
  if musicfox:is_open() then
    musicfox:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Run musicfox" })

-- lazygit
map("n", "<leader>gg", function()
  lazygit:toggle()
  if lazygit:is_open() then
    lazygit:set_mode(toggleterm.mode.INSERT)
  end
end, { desc = "Run lazygit" })

-- fork
map("n", "<leader>gf", function()
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

-- GenComment
local neogen = require("neogen")
map({ "n" }, "<leader>cc", function()
  neogen.generate({})
end, { desc = "Gen Comment" })

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
  -- telescope_builtin.lsp_document_symbols(ivy_theme)
  telescope.extensions.aerial.aerial(ivy_theme)
end, { desc = "Document symbols" })
map({ "i", "n", "v" }, "<D-S-m>", function()
  -- telescope_pickers.prettyDocumentSymbols({ symbols = require("lazyvim.config").get_kind_filter() })
  -- telescope_builtin.lsp_document_symbols(ivy_theme)
  telescope.extensions.aerial.aerial(ivy_theme)
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

-- pin buffer
map({ "n", "v", "i" }, "<D-p>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if state.is_pinned(bufnr) then
    return
  end
  state.toggle_pin(bufnr)
end, { desc = "Pin cur buffer" })

-- disable ScrollWheelLeft, ScrollWheelRight
map({ "n", "v", "i", "s", "c", "o" }, "<ScrollWheelLeft>", "<Nop>", { desc = "Disabled", noremap = true })
map({ "n", "v", "i", "s", "c", "o" }, "<ScrollWheelRight>", "<Nop>", { desc = "Disabled", noremap = true })
map({ "n", "v", "i", "s", "c", "o" }, "<S-ScrollWheelLeft>", "<ScrollWheelLeft>", { desc = "Disabled", noremap = true })
map(
  { "n", "v", "i", "s", "c", "o" },
  "<S-ScrollWheelRight>",
  "<ScrollWheelRight>",
  { desc = "Disabled", noremap = true }
)

-- Aerial
map({ "n" }, "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial" })

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
map({ "n", "i", "v" }, "<D-LeftMouse>", "<LeftMouse><cmd>normal gd<cr>", { desc = "Jump to", noremap = true })
map({ "n", "i", "v" }, "<RightMouse>", "<LeftMouse><cmd>normal K<cr>", { desc = "Jump to", noremap = true })
