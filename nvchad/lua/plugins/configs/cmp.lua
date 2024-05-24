local cmp = require("cmp")
local lspkind = require("lspkind")
dofile(vim.g.base46_cache .. "cmp")

local cmp_ui = require("core.utils").load_config().ui.cmp
local cmp_style = cmp_ui.style
local defaults = require("cmp.config.default")()
-- local field_arrangement = {
-- 	atom = { "kind", "abbr", "menu" },
-- 	atom_colored = { "kind", "abbr", "menu" },
-- }

local formatting_style = {
	-- default fields order i.e completion word + item.kind + item.kind icons
	fields = { "abbr", "kind", "menu" },
	-- fields = field_arrangement[cmp_style] or { "kind", "menu" },

	format = function(_, item)
		local icons = require("lspkind")
		local icon = (cmp_ui.icons and icons[item.kind]) or ""

		if cmp_style == "atom" or cmp_style == "atom_colored" then
			-- icon = " " .. icon .. " "
			item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
			item.kind = icon
		else
			icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
			item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
		end

		return item
	end,
}

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local options = {
	-- help cmp for documentation
	completion = {
		-- @was
		completeopt = "noselect,menu,menuone",
	},
	performance = {
		-- debounce = 100,
		-- throttle = 400,
		max_view_entries = 8,
	},
	window = {
		completion = {
			-- side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
			-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
			winblend = 10,
			scrollbar = false,
		},
		documentation = {
			-- border = border("CmpDocBorder"),
			border = "none",
			winblend = 10,

			-- winhighlight = "Normal:CmpDoc",
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	-- formatting = formatting_style,
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = "" -- display nothing or icons?

			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	-- formatting = {
	-- 	format = lspkind.cmp_format({
	-- 		mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	-- 		maxwidth = function()
	-- 			return math.floor(0.45 * vim.o.columns)
	-- 		end, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
	-- 		ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
	-- 		-- show_labelDetails = disable, -- show labelDetails in menu. Disabled by default
	-- 	}),
	-- },
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{
			name = "buffer",
			option = {
				indexing_interval = 1000,
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "nvim_lua" },
		{ name = "path" },
		-- {
		-- 	name = "rg",
		-- 	keyword_length = 3,
		-- 	option = { additional_arguments = "--max-depth 3", debug = true },
		-- },
		-- { name = "nvim_lsp_signature_help" },
	},
	-- experimental = {
	-- 	ghost_text = {
	-- 		hl_group = "CmpGhostText",
	-- 	},
	-- },
	sorting = defaults.sorting,
}

-- if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
-- 	options.window.completion.border = border("CmpBorder")
-- end
-- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
return options
