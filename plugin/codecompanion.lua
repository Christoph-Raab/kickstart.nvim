vim.pack.add {
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/j-hui/fidget.nvim',
}
require('codecompanion').setup {
  provider = 'copilot',
  interactions = {
    chat = {
      adapter = {
        name = 'copilot',
        model = 'claude-sonnet-4.6',
      },
      roles = { user = 'Chris' },
    },
    inline = {
      adapter = {
        name = 'copilot',
        model = 'claude-haiku-4.5',
      },
    },
  },
}
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
-- Configure fidget.nvim to show progress for CodeCompanion requests
local progress = require 'fidget.progress'
local handles = {}
local group = vim.api.nvim_create_augroup('CodeCompanionFidget', { clear = true })

vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeCompanionRequestStarted',
  group = group,
  callback = function(e)
    handles[e.data.id] = progress.handle.create {
      title = 'CodeCompanion',
      message = 'Thinking...',
      lsp_client = { name = e.data.adapter.formatted_name },
    }
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeCompanionRequestFinished',
  group = group,
  callback = function(e)
    local h = handles[e.data.id]
    if h then
      h.message = e.data.status == 'success' and 'Done' or 'Failed'
      h:finish()
      handles[e.data.id] = nil
    end
  end,
})
vim.keymap.set('n', '<leader>cn', '<cmd>CodeCompanionChat<cr>')
vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>')
