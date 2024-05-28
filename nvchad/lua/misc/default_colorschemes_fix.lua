vim.cmd([[
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight Normal ctermbg=none
highlight VertSplit ctermbg=none
highlight NonText ctermbg=none
highlight StatusLine ctermbg=none
highlight StatusLine ctermfg=Grey
highlight StatusLineNC ctermbg=none
highlight StatusLineNC ctermfg=DarkGrey
highlight GitSignsAdd ctermfg=Green
highlight GitSignsChange ctermfg=Yellow
highlight GitSignsDelete ctermfg=Red
highlight TabLine ctermfg=none ctermbg=none
highlight TabLineFill ctermfg=DarkGrey ctermbg=none
highlight TabLineSel ctermfg=White ctermbg=none
highlight Visual ctermfg=none ctermbg=Black
hi LineNr guifg=NONE guibg=NONE
hi clear Float
hi clear NonText
hi clear NormalFloat
hi link NonText Normal
]])
-- vim.cmd("hi LineNr guifg=NONE guibg=NONE")

-- fix for all vim colorschemes
-- vim.cmd.hi("clear Float")
-- vim.cmd.hi("clear NonText")
-- vim.cmd.hi("clear NormalFloat")
-- vim.cmd.hi("link NonText Normal")
-- vim.cmd.hi("link Float Folded")
-- vim.cmd.hi("link NormalFloat Folded")
