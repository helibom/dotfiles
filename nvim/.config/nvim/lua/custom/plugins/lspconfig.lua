-- 	Regarding Mason, the plugin allow you to ->
-- 	- register a setup hook with lspconfig that ensures servers installed with mason.nvim are set up with the necessary configuration
--	- provide extra convenience APIs such as the :LspInstall command
-- 	- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
-- 	- translate between lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
return {
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.*",
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
			require("mason-lspconfig").setup({
				ensure_installed = {
					"nil_ls",
					"lua_ls",
					"jsonls",
					"yamlls",
					"ts_ls",
					"denols",
					"cssls",
					"tailwindcss",
					"pylsp",
					"clojure_lsp",
					-- "csharp_ls",
					"bashls",
					"texlab",
					"marksman",
				}
			})
			local lspconfig = require("lspconfig")

			-- ######### TYPESCRIPT SERVERS ############# --	
			lspconfig.ts_ls.setup {
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				single_file_support = false,
				on_attach = function(client, bufnr)
					-- Disable formatting from tsserver
					client.server_capabilities.document_formatting = false
				end,
				-- commands = {
				--     OrganizeImports = {
				-- 	organize_imports,
				-- 	description = "Organize Imports",
				--     },
				-- },
			}
			lspconfig.denols.setup {
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				-- on_attach = function(client, bufnr)
				-- vim.cmd "LspStop ts_ls"
				-- end,
			}

			-- ######### GRAPHQL ############# --	
			lspconfig.graphql.setup({
				capabilities = capabilities,
				-- absolute path to compiled cli
				cmd = { "~/.local/share/nvim/mason/bin/graphql-lsp", "server", "-m", "stream" }, -- [-s | --schema] {schemaPath}
				-- I do not need it in other filetypes, adjust for your needs
				filetypes = { 'graphql' },
				root_dir = lspconfig.util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
			})

			-- ######### NIX SERVERS ############# --
			lspconfig.nil_ls.setup {
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("flake.nix", "nixpkgs.json", "nix-config.json"),
				settings = {
					nil_ls = {
						formatting = {
							command = "nixfmt",
						},
					},
				},
			}

			-- ######### LISP SERVERS ############# --
			lspconfig.fennel_ls.setup { capabilities = capabilities }

			-- ######### MISC SERVERS ############# --
			lspconfig.marksman.setup { capabilities = capabilities, filetypes = { "markdown" } }
			lspconfig.jdtls.setup { capabilities = capabilities }
			lspconfig.lua_ls.setup { capabilities = capabilities }
			lspconfig.jsonls.setup { capabilities = capabilities }
			lspconfig.pylsp.setup { capabilities = capabilities }
			lspconfig.yamlls.setup { capabilities = capabilities }
			lspconfig.cssls.setup { capabilities = capabilities }
			lspconfig.tailwindcss.setup { capabilities = capabilities }
			lspconfig.clojure_lsp.setup { capabilities = capabilities }
			lspconfig.csharp_ls.setup { capabilities = capabilities }
			lspconfig.bashls.setup { capabilities = capabilities }
			lspconfig.graphql.setup { capabilities = capabilities }
			lspconfig.prismals.setup { capabilities = capabilities }
			lspconfig.texlab.setup { capabilities = capabilities }

			vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set('i', '<C-Space>', vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- if client and client.supports_method('textDocument/documentation') then
					-- Create a keymap for vim.lsp.buf.
					-- end
					if client and client.supports_method('textDocument/implementation') then
						-- Create a keymap for vim.lsp.buf.implementation
						vim.keymap.set('n', 'cd', vim.lsp.buf.implementation, { desc = "LSP Implementation" })
					end
				end,
			})
		end,
	}
}
