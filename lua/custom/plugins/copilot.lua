return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        accept = false, -- disable built-in keymapping
        keymap = {
          accept = '<M-a>',
          accept_word = '<M-w>',
          accept_line = '<M-s>',
          next = '<M-n>',
          prev = '<M-p>',
          dismiss = '<M-e>',
        },
      },
      panel = { enabled = false },
    }
  end,
}
