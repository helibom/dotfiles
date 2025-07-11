return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
							["]p"] = {
								query = "@parameter.inner",
								desc = "TSTextObjects: Go to Next Start of Inner Parameter",
							},
						},
						goto_next_end = {
							["]M"] = {
								query = "@function.outer",
								desc = "TSTextObjects: Go To Next End of Outer Function",
							},
							["]["] = { query = "@class.outer", desc = "TSTextObjects: Go to Next End of Outer Class" },
						},
						goto_previous_start = {
							["[m"] = {
								query = "@function.outer",
								desc = "TSTextObjects: Go to Previous Start of Outer Function",
							},
							["[["] = {
								query = "@class.outer",
								desc = "TSTextObjects: Go to Previous Start Outer Class",
							},
							["[p"] = {
								query = "@parameter.inner",
								desc = "TSTextObjects: Go to Previous Start of Inner Parameter",
							},
						},
						goto_previous_end = {
							["[M"] = {
								query = "@function.outer",
								desc = "TSTextObjects: Go to Previous End of Outer Function",
							},
							["[]"] = {
								query = "@class.outer",
								desc = "TSTextObjects: Go to Previous End of Outer Class",
							},
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = {
								query = "@conditional.outer",
								desc = "TSTextObjects: Go to Next Outer Conditional",
							},
						},
						goto_previous = {
							["[d"] = {
								query = "@conditional.outer",
								desc = "TSTextObjects: Go to Previous Outer Conditional",
							},
						},
					},
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = { query = "@function.outer", desc = "TSTextObjects: Select Outer Function" },
							["if"] = { query = "@function.inner", desc = "TSTextObjects: Select Inner Function" },
							["ac"] = { query = "@class.outer", desc = "TSTextObjects: Select Outer Class" },
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "TSTextObjects: Select Inner Class" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = {
								query = "@local.scope",
								query_group = "locals",
								desc = "TSTextObjects: Select Local Scope",
							},
							["ip"] = { query = "@parameter.inner", desc = "TSTextObjects: Select Inner Parameter" },
							["ap"] = { query = "@parameter.outer", desc = "TSTextObjects: Select Outer Parameter" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = false,
					},
				},
			})
		end,
	},
}
