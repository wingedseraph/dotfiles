local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
g.toggle_theme_icon = ""
-- g.toggle_theme_icon = "   "
g.transparency = true

-------------------------------------- options ------------------------------------------
vim.cmd([[set nocompatible]])
opt.laststatus = 2 -- global statusline
opt.showmode = true

opt.cursorline = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = { shift = 2 }

-- Mine
-- opt.showbreak = "↳" -- character for line break
opt.showbreak = "" -- ↪	⤷ ↳

opt.listchars = { tab = "ᐧᐧᐧ", multispace = " ", trail = "·", extends = "⟩", precedes = "⟨" } -- Make whitespace more informative in your buffer
-- opt.listchars = { eol = "↩", space = "·", tab = "→ " }

opt.scrolloff = 8
-- vim.o.guicursor = "n-v-c-i:block" -- NOTE: bold caret in insert mode TESTING
opt.wrap = false
-- opt.list = true -- display trailing space
-- opt.sidescrolloff = 30
opt.swapfile = false
opt.backup = false
opt.relativenumber = false
opt.number = false
-- opt.langmap =
-- "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
local langmap_keys = {
	"ёЁ;`~",
	"№;#",
	"йЙ;qQ",
	"цЦ;wW",
	"уУ;eE",
	"кК;rR",
	"еЕ;tT",
	"нН;yY",
	"гГ;uU",
	"шШ;iI",
	"щЩ;oO",
	"зЗ;pP",
	"хХ;[{",
	"ъЪ;]}",
	"фФ;aA",
	"ыЫ;sS",
	"вВ;dD",
	"аА;fF",
	"пП;gG",
	"рР;hH",
	"оО;jJ",
	"лЛ;kK",
	"дД;lL",
	[[жЖ;\;:]],
	[[эЭ;'\"]],
	"яЯ;zZ",
	"чЧ;xX",
	"сС;cC",
	"мМ;vV",
	"иИ;bB",
	"тТ;nN",
	"ьЬ;mM",
	[[бБ;\,<]],
	"юЮ;.>",
}
vim.o.langmap = table.concat(langmap_keys, ",")
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
-- Disable netrw banner
g.netrw_banner = 0
-- Numbers
opt.numberwidth = 1
opt.ruler = false

opt.shortmess:append("sI")
opt.diffopt = { -- Option settings for diff mode.
	"filler", -- Show filler lines.
	"vertical", -- Start diff mode with vertical splits.
	"hiddenoff", -- Do not use diff mode for a buffer when it becomes hidden.
	"foldcolumn:0", -- Set the 'foldcolumn' option to 0.
	"algorithm:histogram", -- Use the specified diff algorithm.
}
opt.foldopen = { -- Specifies for which type of commands folds will be opened.
	"hor", -- Horizontal movements: "l", "w", "fx", etc.
	"mark", -- Jumping to a mark: "'m", CTRL-O, etc.
	"percent", -- % key.
	"quickfix", -- ":cn", ":crew", ":make", etc.
	"tag", -- Jumping to a tag: ":ta", CTRL-T, etc.
	"undo", -- Undo or redo: "u" and CTRL-R.
}
opt.confirm = true
opt.signcolumn = "no"
-- opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 500
opt.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete.
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- reload some chadrc options on-save
autocmd("BufWritePost", {
	pattern = vim.tbl_map(function(path)
		return vim.fs.normalize(vim.loop.fs_realpath(path))
	end, vim.fn.glob(vim.fn.stdpath("config") .. "/lua/custom/**/*.lua", true, true, true)),
	group = vim.api.nvim_create_augroup("ReloadNvChad", {}),

	callback = function(opts)
		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

		require("plenary.reload").reload_module("base46")
		require("plenary.reload").reload_module(module)
		require("plenary.reload").reload_module("custom.chadrc")

		config = require("core.utils").load_config()

		vim.g.nvchad_theme = config.ui.theme
		vim.g.transparency = config.ui.transparency

		-- statusline
		-- require("plenary.reload").reload_module("nvchad.statusline." .. config.ui.statusline.theme)
		-- vim.opt.statusline = "%!v:lua.require('nvchad.statusline." .. config.ui.statusline.theme .. "').run()"

		-- -- tabufline
		-- if config.ui.tabufline.enabled then
		-- 	require("plenary.reload").reload_module("nvchad.tabufline.modules")
		-- 	vim.opt.tabline = "%!v:lua.require('nvchad.tabufline.modules').run()"
		-- end

		-- implement colorscheme
		-- require("base46").load_all_highlights()
		-- vim.cmd("redraw!")
	end,
})

-- Spelling ===================================================================
-- vim.o.spelllang = "en,ru,uk" -- Define spelling dictionaries
-- vim.o.spelloptions = "camel" -- Treat parts of camelCase words as seprate words
-- vim.opt.complete:append("kspell") -- Add spellcheck options for autocomplete
-- vim.opt.complete:remove("t") -- Don't use tags for completion
--
-- vim.o.dictionary = vim.fn.stdpath("config") .. "lua/misc/dict/english.txt" -- Use specific dictionaries
opt.undodir = os.getenv("HOME") .. "/.config/nvim/tmp/undo"
opt.undofile = true
opt.inccommand = "split"
