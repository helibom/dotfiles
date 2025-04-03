
vim.api.nvim_create_user_command('YankFilenameRelative', function()
  vim.fn.setreg('+', vim.fn.expand('%:.'))
end, {})

vim.api.nvim_create_user_command('YankFilenameAbsolute', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, {})

vim.keymap.set('n', '<leader>yf', '<Cmd>YankFilenameRelative<CR>', { desc = "Yank Relative Filename to '+' Register"})
vim.keymap.set('n', '<leader>yF', '<Cmd>YankFilenameAbsolute<CR>', { desc = "Yank Absolute Filename to '+' Register"})
