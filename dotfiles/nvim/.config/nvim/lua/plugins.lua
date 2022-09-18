vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- specified as strings
  use 'rstacruz/vim-closer'

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'tjdevries/colorbuddy.nvim'
  use 'bkegley/gloombuddy'

  use 'nvim-lua/completion-nvim'

  use {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
  }

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'

  use 'nvim-telescope/telescope-file-browser.nvim'

  -- For Java
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-jdtls'

  -- Bootstrap configuration
  if packer_bootstrap then
      require('packer').sync()
  end

end)
