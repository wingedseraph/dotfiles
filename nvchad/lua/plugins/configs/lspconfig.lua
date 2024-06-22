dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp")
local lspconfig = require("lspconfig")

local M = {}
local utils = require("core.utils")

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	if client.server_capabilities.documentSymbolProvider then
		if vim.bo.filetype == "html" then
			if pcall(require, "nvim-navic") then
				require("nvim-navic").attach(client, bufnr)
			end
		end
	end
	utils.load_mappings("lspconfig", { buffer = bufnr })

	-- if client.server_capabilities.signatureHelpProvider then
	-- 	require("nvchad.signature").setup(client)
	-- end

	if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end
M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- border = "double",

	-- none, double, single, shadow, rounded, solid
	-- block, inner_block, thinblock, inner_thinblock,
	-- bullet, star, simple, light_shade, medium_shade,
	-- dark_shade, arrow, full_block, diff
	border = require("misc.border").rounded,
})

return M
