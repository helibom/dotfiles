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
	    require("mason").setup()
	    require("mason-lspconfig").setup({
		ensure_installed = {
		    "lua_ls"
		}
	    })
	    -- ######### SERVERS ############# -- 
	    require("lspconfig").lua_ls.setup {}
	    require("lspconfig").tsserver.setup {}
	    require("lspconfig").bashls.setup {}
	    require("lspconfig").graphql.setup {}


	    vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
		    local client = vim.lsp.get_client_by_id(args.data.client_id)
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
