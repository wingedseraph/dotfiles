local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table

local servers = {
	"html",
	"cssls",
	"pylsp",
	"tsserver",
	-- "denols",
	"clangd",
	"gopls",
	-- "lua_ls",
}
local border = {
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
	{ "", "FloatBorder" },
}
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- handlers = handlers,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- lspconfig.pyright.setup { blabla}
lspconfig.tsserver.setup({
	-- handlers = handlers,
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
})
-- lspconfig.lua_ls.setup({
-- 	-- handlers = handlers,
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 				disable = { "undefined-global" },
-- 			},
-- 		},
-- 	},
-- })
lspconfig.clangd.setup({
	on_attach = on_attach,
	-- handlers = handlers,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--pch-storage=memory",
		"--clang-tidy",
		"--suggest-missing-includes",
		"--cross-file-rename",
		"--completion-style=detailed",
		"--offset-encoding=utf-16",
	},
})
-- Setup required for ufo
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
lspconfig.lua_ls.setup({
	on_attach = on_attach,
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
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
