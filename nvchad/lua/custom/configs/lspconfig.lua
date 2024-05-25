local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table

local servers = {
	"html",
	"cssls",
	-- "pylsp",
	-- "basedpyright",
	"tsserver",
	-- "pyright",
	"basedpyright",
	-- "denols",
	-- "clangd",
	"gopls",
	-- "lua_ls",
}
lspconfig.tsserver.setup({
	settings = {},
	on_attach = require("plugins.configs.lspconfig").on_attach,
	capabilities = require("plugins.configs.lspconfig").capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
})

-- @lua
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- lspconfig.pyright.setup { blabla}

-- lspconfig.clangd.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = {
-- 		"clangd",
-- 		"--background-index",
-- 		"--pch-storage=memory",
-- 		"--clang-tidy",
-- 		"--suggest-missing-includes",
-- 		"--cross-file-rename",
-- 		"--completion-style=detailed",
-- 		"--offset-encoding=utf-16",
-- 	},
-- })
-- Setup required for ufo
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
lspconfig.lua_ls.setup({
	on_attach = require("plugins.configs.lspconfig").on_attach,
	capabilities = require("plugins.configs.lspconfig").capabilities,

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

-- @else
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- @javascript
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
})
-- @c++
lspconfig.clangd.setup({
	on_attach = on_attach,
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
