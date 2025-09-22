local M = {}

local map = vim.keymap.set
map('n', '<leader>w', '<cmd>write<cr>', { desc = '[W]rite buffer', silent = true })
map('n', '<leader>z', '<cmd>bdelete<cr>', { desc = 'Close buffer', silent = true })
map('n', '<leader>vv', '<c-v>', { desc = 'Visual Block Mode', silent = true, noremap = true })
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

return M
