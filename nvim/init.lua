-- bootstrap lazy.nvim, LazyVim and your plugins

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- for kitty, must be here
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
  end,
})

require("config.lazy")

vim.g.guifont = "JetbrainsMono Nerd Font"
vim.g.guifontsize = 15
vim.opt.guifont = vim.g.guifont .. ":h" .. vim.g.guifontsize
-- vim.opt.linespace = 6
-- vim.opt.guifont = "ComicMono NF:h16"
-- vim.opt.guifont = "MesloLGLDZ Nerd Font Mono:h15"
-- vim.opt.fileencoding = "utf-8"
vim.opt.filetype = "on"
vim.opt.ignorecase = true
vim.opt.smartcase = false
vim.opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,terminal"
vim.opt.jumpoptions = "stack"
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.winblend = 10
vim.opt.pumblend = 10
vim.opt.mousemoveevent = true
vim.opt.termguicolors = true
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 999 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 999
vim.opt.foldenable = true
vim.opt.list = false

vim.diagnostic.config({
  underline = true,
  float = {
    source = true,
  },
})

vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1

vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- highlight
vim.cmd("hi Folded cterm=italic ctermfg=245 ctermbg=0 gui=italic guifg=#928374 guibg=0")
vim.cmd("hi GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#858577 guibg=0")
vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=0 guifg=#767676")

local colors = require("utils.colors")
vim.cmd("hi DashboardHeader guifg=" .. colors.random_color())
vim.cmd("hi DashboardFooter guifg=#787c99")
vim.cmd("hi DashboardFind guifg=#C0CAF5")
vim.cmd("hi DashboardRecent guifg=#9d7cd8")
vim.cmd("hi DashboardProject guifg=#7aa2f7")
vim.cmd("hi DashboardConfiguration guifg=#ffffff")
vim.cmd("hi DashboardSession guifg=#9ece6a")
vim.cmd("hi DashboardLazy guifg=#0DB9D7")
vim.cmd("hi DashboardServer guifg=#e0af68")
vim.cmd("hi DashboardQuit guifg=#f7768e")
vim.cmd("hi ColorColumn guibg=#323232")

-- for neovim >= 0.10.0
vim.cmd("hi! link @variable Identifier")
vim.cmd("hi! link @constant Constant")
vim.cmd("hi Pmenu guifg=0 guibg=#353535")
vim.cmd("hi! link NormalFloat Pmenu")
vim.cmd("hi! link Delimiter Special")
vim.cmd("hi! link Title GruvboxGreenBold")
vim.cmd("hi! link @type.builtin GruvboxYellow")
vim.cmd("hi! link @variable.builtin Special")
vim.cmd("hi! link @lsp.typemod.variable.readonly Constant")
vim.cmd("hi! link @lsp.typemod.variable.defaultLibrary GruvboxPurple")
vim.cmd("hi! link @lsp.type.member Function")
vim.cmd("hi! link @lsp.type.property Field")
vim.cmd("hi! link SagaTitle GruvboxBlueBold")
vim.cmd("hi! link SagaFinderFname GruvboxAqua")

-- for telescope
local base30 = require("utils.gruvbox").base_30
vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", base30.pink, base30.one_bg2))
vim.cmd(string.format("hi TelescopeNormal guibg=%s", base30.black2))
vim.cmd(string.format("hi TelescopePreviewTitle guifg=%s guibg=%s", base30.one_bg, base30.green))
vim.cmd(string.format("hi TelescopePromptTitle guifg=%s guibg=%s", base30.one_bg, base30.pink))
vim.cmd(string.format("hi TelescopeSelection guifg=%s guibg=%s", base30.white, base30.one_bg3))
vim.cmd(string.format("hi TelescopeSelectionCaret guifg=%s guibg=%s", base30.one_bg3, base30.one_bg3))
vim.cmd(string.format("hi TelescopeResultsDiffAdd guifg=%s", base30.green))
vim.cmd(string.format("hi TelescopeResultsDiffChange guifg=%s", base30.yellow))
vim.cmd(string.format("hi TelescopeResultsDiffDelete guifg=%s", base30.pink))
vim.cmd(string.format("hi TelescopeMatching guifg=%s", base30.orange))
vim.cmd(string.format("hi TelescopeBorder guifg=%s guibg=%s", base30.black2, base30.black2))
vim.cmd(string.format("hi TelescopePromptBorder guifg=%s guibg=%s", base30.one_bg2, base30.one_bg2))
vim.cmd(string.format("hi TelescopePromptNormal guifg=%s guibg=%s", base30.white, base30.one_bg2))
vim.cmd(string.format("hi TelescopeResultsTitle guifg=%s guibg=%s", base30.one_bg2, base30.orange))
vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", base30.pink, base30.one_bg2))
vim.cmd(string.format("hi TelescopePromptCounter guifg=%s guibg=%s", base30.pink, base30.one_bg2))

-- next is for neovide
if not vim.g.neovide then
  return
end

vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=#393235 guifg=#767676")
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_transparency = 0.8
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_shadow = true
vim.g.neovide_scroll_animation_length = 0
-- vim.g.neovide_background_color = "#0f111700"

-- vim.g.transparency = 0.8
-- local alpha = function()
--   return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
-- end
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_input_ime = true

-- vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_refresh_rate_idle = 60
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_cursor_vfx_mode = "pixiedust"
-- vim.g.neovide_cursor_vfx_particle_density = 15.0
vim.g.neovide_fullscreen = true
vim.g.neovide_input_macos_alt_is_meta = true

-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
