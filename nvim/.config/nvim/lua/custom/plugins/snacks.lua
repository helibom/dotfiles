Banner = [[
██░ ██╗███████╗██╗     ██╗██████╗  ██████╗ ███╗   ███╗
██║ ██║██╔════╝██║     ██║██╔══██╗██╔═══██╗████╗ ████║
███████║█████╗  ██║     ██║██████╔╝██║   ██║██╔████╔██║
██╔══██║██╔══╝  ██║     ██║██╔══██╗██║   ██║██║╚██╔╝██║
██║  ██║███████╗███████╗██║██████╔╝╚██████╔╝██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═════╝  ╚═════╝ ╚═╝     ╚═╝]]

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			width = 60,
			---@class snacks.dashboard.Config
			---@field enabled? boolean
			---@field sections snacks.dashboard.Section
			---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
			row = nil, -- dashboard position. nil for center
			col = nil, -- dashboard position. nil for center
			pane_gap = 4, -- empty columns between vertical panes
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			-- These settings are used by some built-in sections
			preset = {
				-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				---@type fun(cmd:string, opts:table)|nil
				pick = nil,
				-- Used by the `keys` section to show keymaps.
				-- Set your custom keymaps here.
				-- When using a function, the `items` argument are the default keymaps.
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = "🔨 ", key = "M", desc = "Mason", action = ":Mason" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				-- Used by the `header` section
				header = Banner,
			},
			-- item field formatters
			formats = {
				icon = function(item)
					if item.file and item.icon == "file" or item.icon == "directory" then
						return M.icon(item.file, item.icon)
					end
					return { item.icon, width = 2, hl = "icon" }
				end,
				footer = { "%s", align = "center" },
				header = { "%s", align = "center" },
				file = function(item, ctx)
					local fname = vim.fn.fnamemodify(item.file, ":~")
					fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
					if #fname > ctx.width then
						local dir = vim.fn.fnamemodify(fname, ":h")
						local file = vim.fn.fnamemodify(fname, ":t")
						if dir and file then
							file = file:sub(-(ctx.width - #dir - 2))
							fname = dir .. "/…" .. file
						end
					end
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
				end,
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		indent = { enabled = true },
		input = { enabled = false }, -- NOTE: Disabled in the mean time while this causes `rest-nvim/rest-nvim` to crash
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
	keys = {
		-- { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		-- { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		-- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		-- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		-- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		-- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		-- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		-- { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
		-- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		-- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
		-- { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		-- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
		-- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
		-- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		-- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
		-- {
		--   "<leader>N",
		--   desc = "Neovim News",
		--   function()
		--     Snacks.win({
		--       file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		--       width = 0.6,
		--       height = 0.6,
		--       wo = {
		--         spell = false,
		--         wrap = false,
		--         signcolumn = "yes",
		--         statuscolumn = " ",
		--         conceallevel = 3,
		--       },
		--     })
		--   end,
		-- }
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				-- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				-- Snacks.toggle.diagnostics():map("<leader>ud")
				-- Snacks.toggle.line_number():map("<leader>ul")
				-- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				-- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
				-- Snacks.toggle.inlay_hints():map("<leader>uh")
				-- Snacks.toggle.indent():map("<leader>ug")
				-- Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
