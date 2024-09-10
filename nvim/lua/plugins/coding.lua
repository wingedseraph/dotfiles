return {
	{
		"stevearc/conform.nvim",
		-- event = { "BufWritePre" },
		-- event = vl,
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettier" } },
				html = { { "prettier" } },
				css = { { "prettier" } },
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 200, lsp_format = "fallback" },
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			require("conform").setup({
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_format = "fallback" }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = vl,
		config = function()
			JS_linters = {}
			if vim.fn.filereadable("./node_modules/.bin/eslint") == 1 then
				table.insert(JS_linters, "eslint_d")
			end

			vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold", "CursorMoved" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()
				end,
			})
			require("lint").linters_by_ft = {
				html = { "htmlhint" },
				javascript = JS_linters,
				javascriptreact = JS_linters,
				typescript = JS_linters,
				typescriptreact = JS_linters,
			}
		end,
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		event = vl,

		keys = {
			{
				"gK",
				"<cmd>TWValues<cr>",
				desc = "Show tailwind CSS values",
			},
		},
		opts = {
			border = "rounded",
			show_unknown_classes = true,
			focus_preview = true,
		},
	},
	{
		"nacro90/numb.nvim",
		event = vl,

		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		event = vl,

		opts = {
			pre_hook = function()
				return vim.bo.commentstring
			end,
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = vl,
	},
	{
		"norcalli/nvim-colorizer.lua",
		enabled = false,
		event = vl,

		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		enabled = false,
		event = vl,
	},
}
