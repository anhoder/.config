local M = {}

local colors = require("utils.colors")

function M.refresh_extra_highlight_for_dark()
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
  vim.cmd("hi! LspReferenceRead guibg=#505c54 gui=bold")
  vim.cmd("hi! LspReferenceWrite guibg=#7f5c54 gui=bold")
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

  -- neotree
  vim.cmd("hi! NeoTreeTabActive gui=bold")
  vim.cmd("hi! NeoTreeTabInactive guifg=#777777 guibg=#141414")
  vim.cmd("hi! NeoTreeTabSeparatorInactive  guifg=#101010 guibg=#141414")

  -- codeium suggestion
  vim.cmd("hi! CodeiumSuggestion guifg=#686868")

  -- spell
  vim.cmd("hi! SpellBad guifg=none")
  vim.cmd("hi! SpellCap guifg=none")
  vim.cmd("hi! SpellRare guifg=none")
  vim.cmd("hi! SpellLocal guifg=none")

  if vim.g.neovide then
    vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=#393235 guifg=#767676")
  end
end

function M.refresh_extra_highlight_for_light()
  vim.cmd("hi Pmenu guifg=#333333 guibg=#e0e0d0")
  vim.cmd("hi! link @variable Identifier")
  vim.cmd("hi! link @constant Constant")
  vim.cmd("hi! link NormalFloat Pmenu")
  vim.cmd("hi! link Delimiter Special")
  vim.cmd("hi! link @type.builtin Type")
  vim.cmd("hi! link @variable.builtin Special")
  vim.cmd("hi! link @lsp.typemod.variable.readonly Constant")
  vim.cmd("hi! link @lsp.type.member Function")
  vim.cmd("hi! link @lsp.type.property Field")

  vim.cmd("hi! LspReferenceRead guibg=#c0d0b0 gui=italic") -- 浅绿
  vim.cmd("hi! LspReferenceWrite guibg=#d0c0c0 gui=bold") -- 浅粉
  vim.cmd("hi! LspReferenceText guibg=#e0e0d0") -- 背景同色
  vim.cmd("hi! Visual guibg=#d0d0c0") -- 浅米黄
  vim.cmd("hi! Folded cterm=italic ctermfg=234 ctermbg=0 gui=italic guifg=#505050 guibg=0")
  vim.cmd("hi! GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#6c7a6e guibg=0")
  vim.cmd("hi! LspInlayHint cterm=italic gui=italic guibg=0 guifg=#505050")
  vim.cmd("hi! MatchParen gui=bold,underline guibg=#f0f0e0 guifg=#333333")

  -- Diff 高亮
  vim.cmd("hi! DiffAdd guibg=#c0d0b0 guifg=none gui=none")
  vim.cmd("hi! DiffDelete guibg=#d0c0c0 guifg=none gui=none")
  vim.cmd("hi! DiffChange guibg=#b0b0a0 guifg=none gui=none")
  vim.cmd("hi! DiffText guibg=#d0c0b0 guifg=none gui=none")

  -- Dashboard
  vim.cmd("hi DashboardHeader guifg=" .. colors.random_color())
  vim.cmd("hi DashboardFooter guifg=#666666")
  vim.cmd("hi DashboardFind guifg=#333333")
  vim.cmd("hi DashboardRecent guifg=#5060a0")
  vim.cmd("hi DashboardProject guifg=#3370c0")
  vim.cmd("hi DashboardConfiguration guifg=#333333")
  vim.cmd("hi DashboardSession guifg=#408040")
  vim.cmd("hi DashboardLazy guifg=#3370c0")
  vim.cmd("hi DashboardLazyExtras guifg=#5060a0")
  vim.cmd("hi DashboardMason guifg=#a08050")
  vim.cmd("hi DashboardQuit guifg=#d35f5f")
  vim.cmd("hi ColorColumn guibg=#e0e0d0") -- 与背景同色

  -- Coverage
  vim.cmd("hi! CoverageCovered ctermfg=0 ctermbg=0 guibg=0 guifg=#6c7a6e")
  vim.cmd("hi! CoveragePartial ctermfg=0 ctermbg=0 guibg=0 guifg=#a08a50")
  vim.cmd("hi! CoverageUncovered ctermfg=0 ctermbg=0 guibg=0 guifg=#d35f5f")

  -- neotree
  vim.cmd("hi! NeoTreeTabActive gui=bold guifg=#333333 guibg=#f0f0e0")
  vim.cmd("hi! NeoTreeTabSeparatorActive guifg=#e0e0d0 guibg=#f0f0e0")
  vim.cmd("hi! NeoTreeTabInactive guifg=#e0e0d0 guibg=#d0d0c0")
  vim.cmd("hi! NeoTreeTabSeparatorInactive guifg=#e0e0d0 guibg=#d0d0c0")

  -- Codeium 建议
  vim.cmd("hi! CodeiumSuggestion guifg=#505050")

  -- spell
  vim.cmd("hi! SpellBad guifg=none")
  vim.cmd("hi! SpellCap guifg=none")
  vim.cmd("hi! SpellRare guifg=none")
  vim.cmd("hi! SpellLocal guifg=none")

  -- Neovide 适配
  if vim.g.neovide then
    vim.cmd("hi LspInlayHint cterm=italic gui=italic guibg=#e0e0d0 guifg=#505050")
  end
end

return M
