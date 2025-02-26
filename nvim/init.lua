-- bootstrap lazy.nvim, LazyVim and your plugins

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- for kitty and alacritty, must be here
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("TerminalInitVimEnter", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
    local window_id = vim.env.ALACRITTY_WINDOW_ID
    if window_id then
      vim.fn.jobstart("alacritty msg config -w " .. window_id .. ' "$(cat ~/.config/alacritty/keybindings-nvim.toml)"')
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = vim.api.nvim_create_augroup("TerminalQuitVimLeave", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
    local window_id = vim.env.ALACRITTY_WINDOW_ID
    if window_id then
      -- os.execute wait for `alacritty msg config`
      os.execute("alacritty msg config -w " .. window_id .. ' "$(cat ~/.config/alacritty/keybindings.toml)"')
    end
  end,
})

require("config.lazy")

-- vim.g.guifont = "MesloLGL Nerd Font"
vim.g.guifont = "JetBrainsMono Nerd Font"
vim.g.guifontsize = 16
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
vim.opt.autochdir = false
vim.opt.foldtext = "v:lua.require('utils.fold_highlight').highlight_foldtext()"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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
vim.g.root_spec = { "cwd", "lsp", { ".git", "lua" } }

-- neovim >= 0.10
vim.cmd("hi Pmenu guifg=0 guibg=#353535")
vim.cmd("hi! link @variable Identifier")
vim.cmd("hi! link @constant Constant")
vim.cmd("hi! link NormalFloat Pmenu")
vim.cmd("hi! link Delimiter Special")
vim.cmd("hi! link @type.builtin Type")
vim.cmd("hi! link @variable.builtin Special")
vim.cmd("hi! link @lsp.typemod.variable.readonly Constant")
vim.cmd("hi! link @lsp.type.member Function")
vim.cmd("hi! link @lsp.type.property Field")

-- highlight
vim.cmd("hi! LspReferenceRead guibg=#505c54")
vim.cmd("hi! LspReferenceWrite guibg=#7f5c54")
vim.cmd("hi! LspReferenceText guibg=#564c44")
vim.cmd("hi! Visual guibg=#796f67")
vim.cmd("hi! Folded cterm=italic ctermfg=245 ctermbg=0 gui=italic guifg=#928374 guibg=0")
vim.cmd("hi! GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#858577 guibg=0")
vim.cmd("hi! LspInlayHint cterm=italic gui=italic guibg=0 guifg=#767676")
vim.cmd("hi! MatchParen gui=bold,underline guibg=#665c54 guifg=#0DB9D7")

vim.cmd("hi! DiffAdd guibg=#35360b guifg=none gui=none")
vim.cmd("hi! DiffDelete guibg=#4d0003 guifg=none gui=none")
vim.cmd("hi! DiffChange guibg=#1f3828 guifg=none gui=none")
vim.cmd("hi! DiffText guibg=#3b2606 guifg=none gui=none")

-- dashboard
local colors = require("utils.colors")
vim.cmd("hi DashboardHeader guifg=" .. colors.random_color())
vim.cmd("hi DashboardFooter guifg=#787c99")
vim.cmd("hi DashboardFind guifg=#C0CAF5")
vim.cmd("hi DashboardRecent guifg=#9d7cd8")
vim.cmd("hi DashboardProject guifg=#7aa2f7")
vim.cmd("hi DashboardConfiguration guifg=#ffffff")
vim.cmd("hi DashboardSession guifg=#9ece6a")
vim.cmd("hi DashboardLazy guifg=#0DB9D7")
vim.cmd("hi DashboardLazyExtras guifg=#737aa2")
vim.cmd("hi DashboardMason guifg=#e0af68")
vim.cmd("hi DashboardQuit guifg=#f7768e")
vim.cmd("hi ColorColumn guibg=#323232")

-- coverage
vim.cmd("hi! CoverageCovered ctermfg=0 ctermbg=0 guibg=0 guifg=#8ec07c")
vim.cmd("hi! CoveragePartial ctermfg=0 ctermbg=0 guibg=0 guifg=#fabd2f")
vim.cmd("hi! CoverageUncovered ctermfg=0 ctermbg=0 guibg=0 guifg=#fb4934")

-- codeium suggestion
vim.cmd("hi! CodeiumSuggestion guifg=#686868")

-- for telescope
-- local base30 = require("utils.gruvbox").base_30
-- vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", base30.pink, base30.one_bg2))
-- vim.cmd(string.format("hi TelescopeNormal guibg=%s", base30.black2))
-- vim.cmd(string.format("hi TelescopePreviewTitle guifg=%s guibg=%s", base30.one_bg, base30.green))
-- vim.cmd(string.format("hi TelescopePromptTitle guifg=%s guibg=%s", base30.one_bg, base30.pink))
-- vim.cmd(string.format("hi TelescopeSelection guifg=%s guibg=%s", base30.white, base30.one_bg3))
-- vim.cmd(string.format("hi TelescopeSelectionCaret guifg=%s guibg=%s", base30.one_bg3, base30.one_bg3))
-- vim.cmd(string.format("hi TelescopeResultsDiffAdd guifg=%s", base30.green))
-- vim.cmd(string.format("hi TelescopeResultsDiffChange guifg=%s", base30.yellow))
-- vim.cmd(string.format("hi TelescopeResultsDiffDelete guifg=%s", base30.pink))
-- vim.cmd(string.format("hi TelescopeMatching guifg=%s", base30.orange))
-- vim.cmd(string.format("hi TelescopeBorder guifg=%s guibg=%s", base30.black2, base30.black2))
-- vim.cmd(string.format("hi TelescopePromptBorder guifg=%s guibg=%s", base30.one_bg2, base30.one_bg2))
-- vim.cmd(string.format("hi TelescopePromptNormal guifg=%s guibg=%s", base30.white, base30.one_bg2))
-- vim.cmd(string.format("hi TelescopeResultsTitle guifg=%s guibg=%s", base30.one_bg2, base30.orange))
-- vim.cmd(string.format("hi TelescopePromptPrefix guifg=%s guibg=%s", base30.pink, base30.one_bg2))
-- vim.cmd(string.format("hi TelescopePromptCounter guifg=%s guibg=%s", base30.pink, base30.one_bg2))

-- next is for neovide
if not vim.g.neovide then
  return
end

vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=#393235 guifg=#767676")
vim.g.neovide_scale_factor = 1
vim.g.neovide_transparency = 1
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_shadow = true
-- vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_background_color = "#0f111700"

-- vim.g.transparency = 0.8
-- local alpha = function()
--   return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
-- end
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

-- vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_input_ime = true

-- vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_refresh_rate = 144
vim.g.neovide_no_idle = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_cursor_vfx_mode = "pixiedust"
-- vim.g.neovide_cursor_vfx_particle_density = 15.0
vim.g.neovide_fullscreen = true
vim.g.neovide_input_macos_option_key_is_meta = "both"
