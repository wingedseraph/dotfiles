return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				tsserver = {
					enabled = false,
				},
				vtsls = {
					-- explicitly add default filetypes, so that we can extend
					-- them in related extras
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
					function()
						local function run_vtsls_commands()
							require("vtsls").commands.organize_imports(0)
							require("vtsls").commands.add_missing_imports(0)
							require("vtsls").commands.remove_unused_imports(0)
							require("vtsls").commands.fix_all(0)
						end

						vim.api.nvim_create_autocmd("BufWritePre", {
							pattern = { "*.js", "*.ts", "*.jsx" },
							callback = function()
								run_vtsls_commands()
							end,
						})
					end,
				},
			},
			setup = {
				tsserver = function()
					-- disable tsserver
					return true
				end,
				vtsls = function(_, opts)
					-- copy typescript settings to javascript
					opts.settings.javascript =
						vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
				end,
			},
		},
	},
}
