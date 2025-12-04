local M = {}

local map = vim.keymap.set
map('n', '<leader>w', '<cmd>write<cr>', { desc = '[W]rite buffer', silent = true })
map('n', '<leader>z', '<cmd>bdelete<cr>', { desc = 'Close buffer', silent = true })
map({ 'n', 'i' }, '<C-t>', function()
  local tabcount = vim.fn.tabpagenr '$'
  if tabcount == 1 then
    vim.cmd 'tab split' -- create the extra tab
  elseif tabcount == 2 then
    vim.cmd 'tabclose' -- close the extra tab
  else
    vim.notify('Multiple tabs open, not closing automatically', vim.log.levels.WARN)
  end
end, { noremap = true, desc = '[f]ullscreen current buffer' })
map('n', '<leader>hn', '<cmd>wall<cr><cmd>Neogit<cr>', { desc = 'Open Neogit floating', silent = true })
map('n', '<leader>yd', function()
  -- vim.fn.setreg('+', vim.fn.expand '%:p:h')
  local dir = vim.fn.expand '%:p:h'
  vim.fn.setreg('+', dir)
  print('Copied directory: ' .. dir)
end, { desc = 'Yank dir of current file' })

return M
