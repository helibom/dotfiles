return {
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- },
	{
		"mistweaverco/kulala.nvim",
		keys = {
			["Open scratchpad"] = { "b", function() require("kulala").scratchpad() end, },
			["Open kulala"] = { "o", function() require("kulala").open() end, },

			["Toggle headers/body"] = { "t", function() require("kulala").toggle_view() end, ft = { "http", "rest" }, },
			["Show stats"] = { "S", function() require("kulala").show_stats() end, ft = { "http", "rest" }, },

			["Close window"] = { "q", function() require("kulala").close() end, ft = { "http", "rest" }, },

			["Copy as cURL"] = { "c", function() require("kulala").copy() end, ft = { "http", "rest" }, },
			["Paste from curl"] = { "C", function() require("kulala").from_curl() end, ft = { "http", "rest" }, },

			["Send request"] = { "s", function() require("kulala").run() end, mode = { "n", "v" }, },
			["Send request <cr>"] = { "<CR>", function() require("kulala").run() end, mode = { "n", "v" }, ft = { "http", "rest" }, },
			["Send all requests"] = { "a", function() require("kulala").run_all() end, mode = { "n", "v" }, },

			["Inspect current request"] = { "i", function() require("kulala").inspect() end, ft = { "http", "rest" }, },
			["Replay the last request"] = { "r", function() require("kulala").replay() end, },

			["Find request"] = { "f", function() require("kulala").search() end, ft = { "http", "rest" }, },
			["Jump to next request"] = { "n", function() require("kulala").jump_next() end, ft = { "http", "rest" }, },
			["Jump to previous request"] = { "p", function() require("kulala").jump_prev() end, ft = { "http", "rest" }, },

			["Select environment"] = { "e", function() require("kulala").set_selected_env() end, ft = { "http", "rest" }, },
			["Manage Auth Config"] = { "u", function() require("lua.kulala.ui.auth_manager").open_auth_config() end, ft = { "http", "rest" }, },
			["Download GraphQL schema"] = { "g", function() require("kulala").download_graphql_schema() end, ft = { "http", "rest" }, },

			["Clear globals"] = { "x", function() require("kulala").scripts_clear_global() end, ft = { "http", "rest" }, },
			["Clear cached files"] = { "X", function() require("kulala").clear_cached_files() end, ft = { "http", "rest" }, },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
			global_keymaps = true,
		},
	}
}
