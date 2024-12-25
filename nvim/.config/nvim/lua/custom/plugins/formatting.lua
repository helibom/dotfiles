return {
    {
	'stevearc/conform.nvim',
	opts = {},
	config = function ()
	    require("conform").setup {
		formatters_by_ft = {
		    json = { "jq" },
		    yaml = { "yamlfmt" },
		    lua = { "stylelua" },
		    typescript = { "prettier" },
		    javascript = { "prettier" },
		    javascriptreact = { "prettier" },
		    typescriptreact = { "prettier" },
		    clojure = { "cljfmt" },
		}
	    }
	end
    }
}
