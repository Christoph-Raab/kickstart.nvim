vim.pack.add { 'https://github.com/cablecreek/tf-docs.nvim' }
require('tf-docs').setup {
  picker = 'telescope',
  win_config = {
    split = 'below',
  },
  providers = {
    'aws',
    'kubernetes',
    'helm',
  },
}
