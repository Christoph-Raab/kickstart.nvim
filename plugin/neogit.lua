vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
}
require('neogit').setup {}

vim.keymap.set('n', '<leader>hn', '<cmd>wall<cr><cmd>Neogit<cr>', { desc = 'Open Neogit floating', silent = true })
