local cmp = require("cmp")
local defaults = require("cmp.config.default")()

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
		completeopt = "noselect,menu,menuone",
	},
	performance = {
		-- debounce = 400,
		-- throttle = 400,
		max_view_entries = 8,
	},
	window = {
		completion = {
			-- side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
			-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
			-- winblend = 10,
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
		-- { name = "rg", keyword_length = 3 },
		{ name = "nvim_lsp_signature_help" },
	},
	experimental = {
		-- ghost_text = {
		-- 	hl_group = "CmpGhostText",
		-- },
	},
	sorting = defaults.sorting,
}

-- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
require("cmp").setup(options)