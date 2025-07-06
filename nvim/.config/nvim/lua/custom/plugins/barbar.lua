return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map("n", "gT", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "gt", "<Cmd>BufferNext<CR>", opts)

			-- Close buffer
			map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)
			map("n", "<leader>bC", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
			map("n", "<leader>beC", "<Cmd>BufferCloseBuffersRight<CR>", opts) -- doesn't work as expected
			map("n", "<leader>bgC", "<Cmd>BufferCloseBuffersLeft<CR>", opts)

			-- Close commands
			--                 :BufferCloseAllButCurrent
			--                 :BufferCloseAllButPinned
			--                 :BufferCloseAllButCurrentOrPinned
			--                 :BufferCloseBuffersLeft
			--                 :BufferCloseBuffersRight

			-- Re-order to previous/next
			-- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
			-- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

			-- Goto buffer in position...
			-- map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
			-- map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
			-- map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
			-- map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
			-- map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
			-- map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
			-- map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
			-- map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
			-- map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
			-- map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

			-- Pin/unpin buffer
			-- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

			-- Goto pinned/unpinned buffer
			--                 :BufferGotoPinned
			--                 :BufferGotoUnpinned
		end,
		config = function()
			require("barbar").setup({
				exclude_name = { "zsh" },
				icons = {
					separator_at_end = false,
				},
			})
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}
