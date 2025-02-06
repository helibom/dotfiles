
local pickers = require "telescope.pickers"
local conf = require "telescope.config".values
local mono_finder = require('telescope.builtin').find_files

local M = {}

local monorepo_fzf = function(options)
    local opts = options or {}
    pickers.new(opts, {
	prompt_title = "Monorepo Fuzzy",
	finder = mono_finder {
	    cwd = opts.cwd or vim.fn.expand("~/work/repos/inca"),
	},
	previewer = conf.file_previewer,
	sorter = require("telescope.sorters").empty(),
    }):find()
end

M.setup = function ()
    vim.keymap.set("n", "<leader>fm", monorepo_fzf)
end

return M
