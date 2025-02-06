return {
    {
	'tpope/vim-fugitive',
	config = function()
	    -- Optional configuration
	    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
	end
    }
}
