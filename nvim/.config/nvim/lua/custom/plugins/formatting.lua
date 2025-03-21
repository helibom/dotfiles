return {
    {
	'stevearc/conform.nvim',
	opts = {},
	config = function ()
	    local conform = require("conform")
	    conform.setup {
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
		}
	    }
	    vim.keymap.set("n", "=C", function ()
		conform.format({}, function (err, did_edit)
		    if err then
			vim.notify("Error: " .. err, vim.log.levels.ERROR)
		    elseif did_edit then
			vim.cmd('echo "Conform(atted)"')
		    end
		end)
	    end, { desc = "Format with conform.nvim" })
	end
    }
}
