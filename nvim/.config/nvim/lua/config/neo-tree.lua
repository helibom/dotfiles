require('neo-tree')
vim.keymap.set('n', '|', '<Cmd>Neotree reveal right<cr>', { desc = 'Reveal Neotree' })
vim.keymap.set('n', '<Bslash>', '<Cmd>Neotree toggle current reveal_force_cwd<cr>', { desc = 'Toggle Neotree' })
vim.keymap.set('n', '<C-Bslash>', '<Cmd>Neotree toggle float git_status<cr>', { desc = 'Toggle Neotree Git Status' })
