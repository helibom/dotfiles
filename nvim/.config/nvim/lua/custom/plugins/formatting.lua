return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					json = { "jq" },
					yaml = { "yamlfmt" },
					lua = { "stylelua" },
					typescript = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					clojure = { "cljfmt", "zprint" },
					htmldjango = { "djlint" },
					nix = { "nixfmt" },
				},
			})
			vim.keymap.set("n", "=C", function()
				conform.format({ async = true, lsp_format = "fallback" }, function(err, did_edit)
					if err then
						vim.notify("Error: " .. err, vim.log.levels.ERROR)
					elseif did_edit then
						vim.cmd('echo "Conform(atted)"')
					end
				end)
			end, { desc = "Format with conform.nvim" })
		end,
	},
	{
		"https://git.sr.ht/~ioiojo/standard-clojure-style.nvim",
		config = function()
			local standard_clojure_style = require("standard-clojure-style")
			standard_clojure_style.setup({
				vim.keymap.set("n", "=J", function()
					standard_clojure_style["format-buffer"]()
					vim.cmd('echo "StandardClojureStyleFormat()"')
				end),
			})
		end,
	},
}
