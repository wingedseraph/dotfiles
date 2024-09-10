vim.keymap.set("n", "<Leader>fd", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.diagnostic.config({
	virtual_text = {
		-- prefix = "@",
		-- prefix = '●', -- Could be '●', '▎', 'x'
		prefix = "",
	},
	signs = false,
	underline = true,
	update_in_insert = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client then
			local signatureProvider = client.server_capabilities.signatureHelpProvider
			if signatureProvider and signatureProvider.triggerCharacters then
				require("misc.signature").setup(client, args.buf)
			end
		end
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- require("lsp_signature").on_attach({
		--    bind = true,
		--    andler_opts = {
		-- })

		vim.diagnostic.config({
			float = { border = "rounded" },
		})
		local function refactor(opts)
			return function()
				require("misc.rename").rename(opts)
			end
		end
		local opts = { buffer = ev.buf }
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set("n", "<space>ra", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<space>ra", refactor({}), opts)
		vim.keymap.set("n", "<space>R", refactor({ text = "", insert = true }), opts)

		vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"gd",
			"<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"gr",
			"<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"gI",
			"<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"gy",
			"<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>",
			{ noremap = true, silent = true }
		)
	end,
})

local languages = {
	"html",
	-- "cssls",
	"tsserver",
	"clangd",
	-- "emmet_ls",
}
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--    border = "rounded",
-- })

return {
	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		event = vl,

		module = "tailwindcss-colors",
		config = function()
			require("tailwindcss-colors").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local css_settings = {
				validate = true,
				lint = {},
			}

			local is_tailwind = vim.fn.filereadable(vim.fn.expand("tailwind.config.*"))
			if is_tailwind == 1 then
				css_settings.lint.unknownAtRules = "ignore"
			end

			require("lspconfig").cssls.setup({
				capabilities = capabilities,
				cmd = { "vscode-css-language-server", "--stdio" },
				filetypes = { "css", "scss", "less" },
				settings = {
					css = css_settings,
					less = {
						validate = true,
					},
					scss = {
						validate = true,
					},
				},
			})
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			})
			require("lspconfig").emmet_ls.setup({
				-- on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"eruby",
					"html",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"pug",
					"typescriptreact",
					"vue",
				},
				init_options = {
					html = {
						options = {
							-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
						},
					},
				},
			})

			-- require("lspconfig").tailwindcss.setup({
			--    on_attach = function()
			--       require("tailwindcss-colors").buf_attach(0)
			--    end,
			-- })

			for _, language in pairs(languages) do
				require("lspconfig")[language].setup({
					capabilities = capabilities,
				})
			end

			-- not sure
			-- vim.keymap.set("n", "<Leader>e", ":EslintFixAll<CR>", { noremap = true, silent = true })

			local symbols = { Error = "", Warn = "", Info = "", Hint = "" }
			for name, icon in pairs(symbols) do
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
			end

			local hl_groups = {
				"DiagnosticUnderlineError",
				"DiagnosticUnderlineWarn",
				"DiagnosticUnderlineInfo",
				"DiagnosticUnderlineHint",
			}
			for _, hl in ipairs(hl_groups) do
				vim.cmd.highlight(hl .. " gui=undercurl")
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		event = vl,
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = vl,

		opts = {
			ensure_installed = {
				"lua_ls",
				"html",
				-- "cssls",
				-- "tsserver",
				-- "eslint", install eslint_d
				"tailwindcss",
			},
		},
	},
}
