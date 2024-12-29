local map = vim.keymap.set
local all_scope = { "n", "v", "i", "s", "c", "o", "t" }

-- Resize window using <ctrl> arrow keys
map(all_scope, "<C-D-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map(all_scope, "<C-D-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map(all_scope, "<C-D-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map(all_scope, "<C-D-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move to window using the <ctrl> hjkl keys
map(all_scope, "<C-A-Left>", "<Esc><Esc><C-w>h", { desc = "Go to left window", noremap = true })
map(all_scope, "<C-A-Down>", "<Esc><Esc><C-w>j", { desc = "Go to lower window", noremap = true })
map(all_scope, "<C-A-Up>", "<Esc><Esc><C-w>k", { desc = "Go to upper window", noremap = true })
map(all_scope, "<C-A-Right>", "<Esc><Esc><C-w>l", { desc = "Go to right window", noremap = true })

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

-- Comment
map({ "i", "n" }, "<D-/>", "<Esc>gcc", { remap = true, desc = "Comment" })
map({ "v" }, "<D-/>", "gc", { remap = true, desc = "Comment selection" })

-- disable ScrollWheelLeft, ScrollWheelRight
map(all_scope, "<ScrollWheelLeft>", "<Nop>", { desc = "Disabled", noremap = true })
map(all_scope, "<ScrollWheelRight>", "<Nop>", { desc = "Disabled", noremap = true })
map(all_scope, "<S-ScrollWheelLeft>", "<ScrollWheelLeft>", { desc = "Disabled", noremap = true })
map(all_scope, "<S-ScrollWheelRight>", "<ScrollWheelRight>", { desc = "Disabled", noremap = true })

-- add quotation
map("v", "'", "\"+xi'<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>'", { desc = "Add single quotation", noremap = true })
map("v", '"', '"+xi"<cmd>set paste<cr><C-r>+<cmd>set nopaste<cr>"', { desc = "Add double quotation", noremap = true })
map("s", "'", "''<cmd>norm! h<cr>", { desc = "Avoiding effect", noremap = true })
map("s", '"', '""<cmd>norm! h<cr>', { desc = "Avoiding effect", noremap = true })

-- window to tab
map({ "n" }, "<leader>w<Tab>", "<C-w>T", { desc = "Break out into a new tab", remap = true })

-- disable neovim internal grr, gra, grn...
map({ "n" }, "grr", "<Nop>", { desc = "Disable grr" })
map({ "n" }, "gra", "<Nop>", { desc = "Disable gra" })
map({ "n" }, "grn", "<Nop>", { desc = "Disable grn" })
