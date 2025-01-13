-- 	Regarding Mason, the plugin allow you to ->
-- 	- register a setup hook with lspconfig that ensures servers installed with mason.nvim are set up with the necessary configuration
--	- provide extra convenience APIs such as the :LspInstall command
-- 	- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
-- 	- translate between lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
return {
    {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
	    "neovim/nvim-lspconfig",
	    "williamboman/mason.nvim",
	    {
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
		    library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		    },
		},
	    },
	},
	config = function()

	    local capabilities = require('blink.cmp').get_lsp_capabilities() -- autocompletion

	    require("mason").setup()
	    ---@diagnostic disable-next-line: missing-fields
	    require("mason-lspconfig").setup({
		ensure_installed = {
		    "lua_ls"
		}
	    })
	    -- ######### SERVERS ############# -- 
	    require("lspconfig").lua_ls.setup { capabilities = capabilities }
	    require("lspconfig").jsonls.setup { capabilities = capabilities }
	    require("lspconfig").yamlls.setup { capabilities = capabilities }
	    require("lspconfig").ts_ls.setup { capabilities = capabilities }
	    require("lspconfig").cssls.setup { capabilities = capabilities }
	    require("lspconfig").clojure_lsp.setup { capabilities = capabilities }
	    require("lspconfig").bashls.setup { capabilities = capabilities }
	    require("lspconfig").graphql.setup { capabilities = capabilities }
	    require("lspconfig").texlab.setup { capabilities = capabilities }

	    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = "LSP Rename" })
	    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
	    vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = "LSP References" })
	    vim.keymap.set('i', '<C-Space>', vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

	    vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
		    local client = vim.lsp.get_client_by_id(args.data.client_id)
			--    if client != nil and client.supports_method('textDocument/documentation?') then
			-- -- Create a keymap for vim.lsp.buf.
			-- return
			--    end
		    if client.supports_method('textDocument/rename') then
			-- Create a keymap for vim.lsp.buf.rename()
		    end
		    if client.supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation
		    end
		end,
	    })
	end,
    }
}
