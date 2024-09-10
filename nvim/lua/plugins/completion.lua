return {
	{
		"hrsh7th/nvim-cmp",
		event = vl,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			---@diagnostic disable-next-line: lowercase-global
			function setAutoCmp(mode)
				if mode then
					require("cmp").setup({
						completion = {
							autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
						},
					})
				else
					require("cmp").setup({
						completion = {
							autocomplete = false,
						},
					})
				end
			end

			setAutoCmp(true)

			-- enable automatic completion popup on typing
			vim.cmd("command CmpOn lua setAutoCmp(true)")

			-- disable automatic competion popup on typing
			vim.cmd("command CmpOff lua setAutoCmp(false)")

			local cmp_compare = require("cmp.config.compare")

			require("luasnip").config.set_config()

			-- vscode format
			local exclude = { "css", "all" }
			require("luasnip.loaders.from_vscode").lazy_load({
				exclude = exclude,
			})
			vim.api.nvim_create_autocmd("InsertLeave", {
				callback = function()
					if
						require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
						and not require("luasnip").session.jump_active
					then
						require("luasnip").unlink_current()
					end
				end,
			})

			local ls = require("luasnip")
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(-1)
			end, { silent = true })

			local lspkind = require("lspkind")
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				performance = {
					debounce = 10,
					throttle = 40,
					max_view_entries = 8,
				},
				window = {
					completion = {
						-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						border = "single",
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					},
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{
						name = "buffer",
						option = {
							indexing_interval = 1000,
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
				}),
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")

					-- keep command mode completion enabled
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
				formatting = {
					format = lspkind.cmp_format({
						mode = "text_symbol", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
						maxwidth = 50,
						ellipsis_char = "...",
						-- menu = {
						--    buffer = "[Buffer]",
						--    nvim_lsp = "[LSP]",
						--    nvim_lua = "[Lua]",
						--    luasnip = "[LuaSnip]",
						--    latex_symbols = "[Latex]",
						-- },
						before = function(entry, vim_item)
							local ok = pcall(require, "tailwindcss-colorizer-cmp")
							if ok then
								vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
							end
							return vim_item
						end,
					}),
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				sorting = {
					comparators = {
						-- cmp_compare.recently_used,
						cmp_compare.order,
					},
				},

				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
}
