-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- used to be "\\"

local set = vim.opt
set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.relativenumber = true
set.wrap = false
-- set.foldmethod = "expr"
-- set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- set.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.api.nvim_set_keymap('n', '\\u', '<Cmd>nohlsearch<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })


-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "custom.plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin-mocha" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
	-- NOTE: This is only needed if you want to develop/hack on plugins
	-- opts = {
	-- 	dev = {
	-- 		path = "~/dev/forks/conjure-deno/plugin",
	-- 		pattern = "sigmaSd",
	-- 		fallback = false, -- fallback to git if the plugin is not found in the path
	-- 	}
	-- }
})
