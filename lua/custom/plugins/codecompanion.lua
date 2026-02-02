return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'j-hui/fidget.nvim',
    },
    -- Required for lazy loading commands
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    init = function()
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
    opts = {
      provider = 'copilot',
      interactions = {
        chat = {
          adapter = {
            name = 'copilot',
            model = 'gpt-5.2',
          },
          roles = { user = 'Chris' },
        },
        inline = {
          adapter = {
            name = 'copilot',
            model = 'gpt-5.2',
          },
        },
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)

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
    end,
    keys = {
      { '<leader>cn', '<cmd>CodeCompanionChat<CR>', desc = 'Open CodeCompanion Chat' },
      { '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>', desc = 'Toggle CodeCompanion Chat' },
      { '<leader>ca', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true } },
    },
  },
}
