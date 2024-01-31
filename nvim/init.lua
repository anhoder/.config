-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.guifont = "JetBrainsMono Nerd Font Mono"
vim.g.guifontsize = 15
vim.opt.guifont = vim.g.guifont .. ":h" .. vim.g.guifontsize
-- vim.opt.linespace = 6
-- vim.opt.guifont = "ComicMono NF:h16"
-- vim.opt.guifont = "MesloLGLDZ Nerd Font Mono:h15"
-- vim.opt.fileencoding = "utf-8"
vim.opt.filetype = "on"
vim.opt.ignorecase = true
vim.opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,terminal"
vim.opt.swapfile = false
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.winblend = 10
vim.opt.pumblend = 10
vim.opt.mousemoveevent = true
vim.opt.termguicolors = true
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 999 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 999
vim.opt.foldenable = true

vim.diagnostic.config({
  underline = true,
  float = {
    source = true,
  },
})

vim.cmd("hi Folded cterm=italic ctermfg=245 ctermbg=0 gui=italic guifg=#928374 guibg=0")
vim.cmd("hi GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#858577 guibg=0")
vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=#393235 guifg=#969696")

-- for neovim >= 0.10.0
vim.cmd("hi! link @variable Identifier")
vim.cmd("hi! link @constant Constant")
vim.cmd("hi! link NormalFloat Pmenu")
vim.cmd("hi! link Delimiter Special")
vim.cmd("hi! link Title GruvboxGreenBold")
vim.cmd("hi! link @type.builtin GruvboxYellow")
vim.cmd("hi! link @variable.builtin GruvboxBlue")

vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1

vim.g.neovide_scale_factor = 1.0
vim.g.neovide_transparency = 0.8
-- vim.g.neovide_background_color = "#0f111700"

-- vim.g.transparency = 0.8
-- local alpha = function()
--   return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
-- end
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_input_ime = true

-- vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.0
vim.g.neovide_refresh_rate_idle = 60
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
-- vim.g.neovide_cursor_vfx_mode = "pixiedust"
-- vim.g.neovide_cursor_vfx_particle_density = 15.0
vim.g.neovide_fullscreen = false
vim.g.neovide_input_macos_alt_is_meta = true

-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)
