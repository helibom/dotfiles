-- This plugin automatically manages characters pairs like,
-- opening and closing brackets, parenthesis, quotations etc.
return {
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
