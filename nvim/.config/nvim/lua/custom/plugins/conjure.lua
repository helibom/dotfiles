return {
	{
		"Olical/conjure",
		ft = {
			"clojure",
			"fennel",
			"racket",
			-- "typescript",
			-- "javascript",
		}, -- etc
		init = function()
			-- Set configuration options here
			-- Uncomment this to get verbose logging to help diagnose internal Conjure issues
			-- This is VERY helpful when reporting an issue with the project
			-- vim.g["conjure#debug"] = true
		end,
	},
	{
		-- 'sigmaSd/conjure-deno',
		-- dev = true,
		-- dir = "~/dev/forks/conjure-deno"
	},
}
