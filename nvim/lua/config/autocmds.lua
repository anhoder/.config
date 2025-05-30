-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- notify filetype
-- vim.api.nvim_create_autocmd("FileType", {
--   callback = function(_)
--     if vim.bo.filetype ~= "notify" and vim.bo.filetype ~= "noice" then
--       vim.notify(vim.bo.filetype)
--     end
--   end,
--   desc = "Notify FileType",
-- })

-- auto format
local auto_format = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
local ignore_format_filetypes = { "php" }
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = auto_format,
  pattern = ignore_format_filetypes,
  callback = function()
    --- @diagnostic disable-next-line
    vim.b.autoformat = false
  end,
})

-- vim startup
local startup = vim.api.nvim_create_augroup("startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = startup,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
  end,
})
-- 换行自动补全注释前导符
vim.api.nvim_create_autocmd("BufEnter", {
  group = startup,
  pattern = "*",
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - { "o", "c", "r" }
    vim.opt.autoindent = true -- 继承上一行缩进
    vim.opt.smartindent = true -- 智能识别代码块
  end,
})

-- PersistedLoadPre
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedLoadPre",
  callback = function()
    -- delete last buffers(neo-tree)
    local buflist = require("utils.buffer").get_listed_buffers()

    for _, bufnr in ipairs(buflist) do
      Snacks.bufdelete(bufnr)
    end
  end,
})

-- PersistedLoadPost
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedLoadPost",
  callback = function()
    local buflist = require("utils.buffer").get_listed_buffers()
    local cwd = vim.fn.getcwd()
    for _, bufnr in ipairs(buflist) do
      -- vim.notify(vim.api.nvim_buf_get_name(bufnr))
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == cwd or string.sub(name, -1) == "/" then
        ---@diagnostic disable-next-line: param-type-mismatch
        pcall(vim.cmd, "bdelete! " .. bufnr)
      end
    end

    vim.api.nvim_set_current_dir(cwd)

    ---@diagnostic disable-next-line: param-type-mismatch
    -- pcall(vim.cmd, "Neotree show dir=" .. cwd)
    -- require("neo-tree.command").execute({ action = "show", dir = cwd })

    -- manually load launch.json
    require("dap.ext.vscode").load_launchjs()
  end,
})

-- VimLeave (wait libuv)
-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
--   callback = function()
--     vim.cmd("sleep 10ms")
--   end,
-- })

-- Git Conflict
vim.api.nvim_create_autocmd("User", {
  pattern = "GitConflictDetected",
  callback = function()
    vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
    vim.keymap.set("n", "<leader>gx]", "<cmd>GitConflictNextConflict<cr>", { desc = "Next git conflict" })
    vim.keymap.set("n", "<leader>gx[", "<cmd>GitConflictPrevConflict<cr>", { desc = "Prev git conflict" })
    vim.keymap.set("n", "<leader>gxo", "<cmd>GitConflictChooseOurs<cr>", { desc = "GitConflict choose ours" })
    vim.keymap.set("n", "<leader>gxt", "<cmd>GitConflictChooseTheirs<cr>", { desc = "GitConflict choose theirs" })
    vim.keymap.set("n", "<leader>gxb", "<cmd>GitConflictChooseBoth<cr>", { desc = "GitConflict choose both" })
    vim.keymap.set("n", "<leader>gx0", "<cmd>GitConflictChooseNone<cr>", { desc = "GitConflict choose none" })
  end,
})

local json_detect = vim.api.nvim_create_augroup("JsonDetect", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = json_detect,
  pattern = { "composer.lock" },
  callback = function()
    vim.o.filetype = "json"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = json_detect,
  pattern = { "launch.json", "*.cjsn", "*.cjson", "*.jsonc", ".eslintrc.json", "tsconfig.json" },
  callback = function()
    vim.o.filetype = "jsonc"
  end,
})

-- for neovide
-- if vim.g.neovide then
--   vim.api.nvim_create_autocmd("BufLeave", {
--     callback = function()
--       vim.g.neovide_scroll_animation_length = 0
--       vim.g.neovide_cursor_animation_length = 0
--     end,
--   })
--   vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--       vim.fn.timer_start(70, function()
--         vim.g.neovide_scroll_animation_length = 0.3
--         vim.g.neovide_cursor_animation_length = 0.08
--       end)
--     end,
--   })
-- end
