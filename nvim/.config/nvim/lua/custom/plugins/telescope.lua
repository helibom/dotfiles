return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                          , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope recently open files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set(
				"n",
				"<leader>fz",
				builtin.current_buffer_fuzzy_find,
				{ desc = "Telescope fuzzy find current buffer" }
			)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Telescope register" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope normal mode keymaps" })
			-- Git
			vim.keymap.set("n", "<leader>fcc", builtin.git_commits, { desc = "Telescope repository commits" })
			vim.keymap.set("n", "<leader>fcb", builtin.git_bcommits, { desc = "Telescope buffer commits" })
			vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Telescope git branches" })
			vim.keymap.set("n", "<leader>ec", function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Telescope Neovim config directory" })
			-- LSP stuff
			vim.keymap.set(
				"n",
				"gD",
				builtin.lsp_definitions,
				{ desc = "Telescope definition of word under cursor, go to if only one" }
			)
			-- Dotfiles picker
			vim.keymap.set("n", "<leader>df", function()
				require("telescope.builtin").find_files({ cwd = "~/dotfiles" })
			end, { desc = "Telescope dotfiles directory" })
		end,
	},
}
