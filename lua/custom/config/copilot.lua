local M = {}

-- disable copilot suggestions when cmp menu is open
vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function() vim.b.copilot_suggestion_hidden = true end,
})

-- re-enable copilot suggestions when cmp menu is closed
vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function() vim.b.copilot_suggestion_hidden = false end,
})

-- toggle copilot on/off
vim.g.copilot_enabled = true
vim.api.nvim_create_user_command('CopilotToggle', function()
  vim.g.copilot_enabled = not vim.g.copilot_enabled

  if vim.g.copilot_enabled then
    -- copilot.lua exposes :Copilot enable/disable (and other subcommands)
    vim.cmd 'Copilot enable'
    vim.notify('Copilot enabled', vim.log.levels.INFO)
  else
    vim.cmd 'Copilot disable'
    vim.notify('Copilot disabled', vim.log.levels.WARN)
  end
end, {})

vim.keymap.set('n', '<leader>ct', '<cmd>CopilotToggle<CR>', { desc = 'Toggle Copilot' })

return M
