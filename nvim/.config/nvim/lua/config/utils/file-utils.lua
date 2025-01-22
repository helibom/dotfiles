
vim.api.nvim_create_user_command('YankFilename', function()
  vim.fn.setreg('+', vim.fn.expand('%:.'))
end, {})

local set
vim.keymap.set('n', '<leader>yf', '<Cmd>YankFilename<CR>', { desc = "Yank Filename to '+' Register"})
