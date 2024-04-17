return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open [O]il' })
    end,
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
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      ---@type NoicePresets
      presets = {},
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'nvim-telescope/telescope.nvim',
    },
    config = function(opts)
      require('noice').setup(opts)
      require('telescope').load_extension 'noice'
      vim.keymap.set('n', '<leader>sm', '<cmd>Telescope noice<cr>', { desc = '[S]earch [M]essages' })
    end,
  },
}
