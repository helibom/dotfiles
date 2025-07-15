return {
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- },
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>rs", desc = "Send request" },
			{ "<leader>rs", desc = "Send all requests" },
			{ "<leader>rs", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps_prefix = "<leader>r",
			kulala_keymaps_prefix = "",
			global_keymaps = true,
			-- global_keymaps = {
			-- 	["Send request"] = { -- sets global mapping
			-- 		"<leader>Rs",
			-- 		function() require("kulala").run() end,
			-- 		mode = { "n", "v" }, -- optional mode, default is n
			-- 		desc = "Send request" -- optional description, otherwise inferred from the key
			-- 	},
			-- 	["Send all requests"] = {
			-- 		"<leader>Ra",
			-- 		function() require("kulala").run_all() end,
			-- 		mode = { "n", "v" },
			-- 		ft = "http", -- sets mapping for *.http files only
			-- 	},
			-- 	["Replay the last request"] = {
			-- 		"<leader>Rr",
			-- 		function() require("kulala").replay() end,
			-- 		ft = { "http", "rest" }, -- sets mapping for specified file types
			-- 	},
			-- 	["Selected environment file"] = {
			-- 		"<leader>Re",
			-- 		function() require("kulala").select_env_file() end,
			-- 		mode = { "n", "v" },
			-- 		ft = { "http", "rest" }, -- sets mapping for specified file types
			-- 	},
			-- 	-- ["Find request"] = false -- set to false to disable
			-- },
		},
	}
}
