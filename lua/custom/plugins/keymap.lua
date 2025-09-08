local M = {}

local map = vim.keymap.set
map('n', '<leader>w', '<cmd>write<cr>', { desc = '[W]rite buffer', silent = true })
map('n', '<leader>z', '<cmd>bdelete<cr>', { desc = 'Close buffer', silent = true })
map('n', '<leader>vv', '<c-v>', { desc = 'Visual Block Mode', silent = true, noremap = true })

return M
