-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.g.syntastic_javascript_checkers = { "eslint" }
vim.g.syntastic_javascript_eslint_exec = "eslint_d"
vim.o.timeoutlen = 900
-- Automatically add 'use strict' to the first line of new JavaScript files
vim.cmd([[
  augroup add_use_strict
    autocmd!
    autocmd BufNewFile *.js silent! 0r !echo "\"use strict\""
  augroup END
]])
-- Automatically add '<!-- prettier-ignore --> ' to the first line of new html files
vim.api.nvim_exec(
	[[
  augroup add_prettier_ignore
    autocmd!
    autocmd BufNewFile *.html call append(0, "<!-- prettier-ignore -->")
  augroup END
]],
	false
)

-- vim.highlight.priorities.semantic_tokens = 95
-- Set transparency for the status line
-- vim.cmd([[ hi StatusLine   guibg=NONE ctermbg=NONE ]])
-- vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
-- vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

-- Set transparency for the active and inactive status line
-- vim.cmd([[ hi StatusLineNC   guibg=NONE ctermbg=NONE ]])

vim.api.nvim_exec(
	[[
  augroup MarkdownConceal
    autocmd!
    autocmd BufRead *.md setlocal conceallevel=2
  augroup END
]],
	false
)

-- Autocmd to jump to the last edited position after reading a buffer
vim.cmd([[
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.fn.argv(0) == "" then
-- 			require("telescope.builtin").oldfiles()
-- 		end
-- 	end,
-- })
--

-------------
-- Neovide --
-------------
if vim.g.neovide then
	vim.cmd("cd")
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}

	vim.g.neovide_theme = "default"
	vim.g.neovide_padding_left = 10
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_underline_stroke_scale = 0.9
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_no_custom_clipboard = true
	vim.keymap.set("v", "<C-c>", "y") -- Copy
	vim.keymap.set("n", "<C-v>", "P") -- Paste normal mode
	vim.keymap.set("v", "<C-v>", "P") -- Paste visual mode
	vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-v>", "<ESC>pa") -- Paste insert mode

	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_remember_window_size = true
	vim.g.remember_window_position = true

	vim.o.switchbuf = "newtab"
	-- impletemt somehow function to disable transparency for neovide buffers
	-- function Trans()
	-- 	vim.cmd("TransparentDisable")
	-- end
	-- vim.api.nvim_exec(
	-- 	[[
	--            autocmd BufEnter * silent lua vim.defer_fn(function() Trans() end, 103)
	--        ]],
	-- 	false
	-- )
end

-----------------------
-- EnableAfterDelay --
-----------------------

-- execute the autocmd only if the file size is less than 100KB
local file_size = vim.fn.getfsize(vim.fn.expand("%"))

if file_size < 100 * 1024 then
	vim.api.nvim_exec(
		[[
             autocmd UIEnter * silent lua vim.defer_fn(function() require('misc.enable_after_delay') end, 253)
        ]],
		false
	)
end
-- zen mode
-- vim.cmd("autocmd VimEnter * lua Zen()")

-- vim.o.path = ".,**"
vim.keymap.set("v", "p", "P")
-- working bad with fzf
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- neorg better work
vim.cmd([[
    augroup SetNorgFileType
        autocmd!
        autocmd BufRead,BufNewFile *.norg lua vim.cmd("setlocal filetype=norg")
    augroup END
]])

-- Set fzf layout options
vim.g.fzf_vim = {
	preview_window = { "right:50%", "P" },
}
-- vim.g.fzf_layout = { window = { width = vim.o.columns, height = vim.o.lines, border = "none" } }
vim.g.fzf_layout = { window = { width = 1.0, height = 1.0, border = "none" } }
vim.env.FZF_DEFAULT_COMMAND = "fdfind  .. --type f --exclude .git -i"

-- Set default fzf options
vim.env.FZF_DEFAULT_OPTS =
	'-i  --reverse --cycle --margin=2 --preview-window noborder --prompt="> " --marker=">" --pointer="◆" --scrollbar="" --layout=reverse --no-preview'
local fzf_default_opts = vim.env.FZF_DEFAULT_OPTS or ""
local additional_opts =
	"--bind=Tab:down --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:-1 --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00 --color=prompt:#d7005f,spinner:-1,pointer:-1,header:#87afaf --color=border:-1,label:#aeaeae,query:#d9d9d9"
vim.env.FZF_DEFAULT_OPTS = fzf_default_opts .. " " .. additional_opts

vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", {
	expr = true,
	desc = "Move cursor down (display and real line)",
})
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", {
	expr = true,
	desc = "Move cursor up (display and real line)",
})
-- remove a.out after leaving *.c file buffer
vim.cmd([[autocmd VimLeave *.c silent! !rm -f a.out]])

-- function Transparency()
-- 	if not vim.g.neovide then
-- 		vim.cmd("TransparentEnable")
-- 		require("base46").toggle_transparency()
-- 	end
-- end
-- vim.api.nvim_exec(
-- 	[[
--         autocmd UIEnter * lua Transparency()
--     ]],
-- 	false
-- )

-- vim.wo.statusline = "%!v:lua.MiniStatusline.active()"
-- vim.api.nvim_set_keymap("n", "<M-j>", "<cmd>bNext<cr>", {
-- 	desc = "next buffer",
-- })

vim.api.nvim_set_keymap("n", "<M-k>", "<cmd>bnext<cr>", {
	desc = "previous buffer",
})
vim.api.nvim_set_keymap("n", "<leader>rc", "<cmd>lua require('base46').load_all_highlights()<cr>", {
	desc = "reload nvchad/base46 colorscheme",
})
-- vim.api.nvim_exec(
-- 	[[
--         autocmd BufEnter * lua require("ufo").closeAllFolds()
--     ]],
-- 	false
-- )
vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_active = true
		vim.diagnostic.enable()
	end
end

vim.keymap.set("n", "<leader>]", Toggle_diagnostics, { noremap = true, silent = true, desc = "toggle diagnostic" })
vim.keymap.set(
	"n",
	"<leader>cd",
	"<cmd>cd %:h<cr>",
	{ noremap = true, silent = true, desc = "change working directory to current file" }
)

-- require("custom.discipline")

-- Folds ======================================================================
vim.o.foldmethod = "indent" -- Set 'indent' folding method
vim.o.foldlevel = 1 -- Display all folds except top ones
vim.o.foldnestmax = 10 -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

if vim.fn.has("nvim-0.10") == 1 then
	-- vim.o.foldtext = "" -- Use underlying text with its highlighting
	function _G.foldtext()
		local line_count = vim.v.foldend - vim.v.foldstart + 1
		local first_line = vim.trim(vim.fn.getline(vim.v.foldstart))
		local indent_level = vim.v.foldlevel - 1
		local indent = string.rep(" ", indent_level * 2)
		return indent .. "  " .. first_line .. " [" .. line_count .. " lines] "
	end

	vim.opt.foldtext = "v:lua.foldtext()"
end
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>copen<cr>", { noremap = true, silent = true })
vim.o.fillchars = table.concat({
	"fold: ",
	"eob: ",
	"horiz:═",
	"horizdown:╦",
	"horizup:╩",
	"vert:║",
	"verthoriz:╬",
	"vertleft:╣",
	"vertright:╠",
}, ",")
vim.o.winblend = 10 -- Make floating windows slightly transparent

function read()
	require("zen-mode").toggle()
	vim.cmd("FSRead")
	vim.cmd("set conceallevel=3")
	vim.cmd("TSEnable highlight")
	vim.o.foldlevel = 20 -- Display all folds except top ones
	vim.cmd("set wrap")
	-- find utils to convert epub and pdf to markdown
end
vim.api.nvim_set_keymap("n", "<leader>re", "<cmd>lua read()<cr>", { noremap = true, silent = true })
