return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'johmsalas/text-case.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('textcase').setup {}
      require('telescope').load_extension 'textcase'
    end,
    keys = {
      'ga', -- Default invocation prefix
      { 'ga.', '<cmd>TextCaseOpenTelescope<CR>', mode = { 'n', 'x' }, desc = 'Telescope' },
    },
  },
}
