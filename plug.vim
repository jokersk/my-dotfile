if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif
call plug#begin()
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'mfussenegger/nvim-dap'
  " Plug 'vim-vdebug/vdebug'
  Plug 'jwalton512/vim-blade'
  Plug 'sbdchd/neoformat'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'folke/trouble.nvim'
  Plug 's1n7ax/nvim-terminal'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'akinsho/flutter-tools.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'karb94/neoscroll.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'nvim-lua/completion-nvim'
  " Plug 'preservim/nerdtree'
  Plug 'folke/tokyonight.nvim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'b3nj5m1n/kommentary'
  Plug 'arcticicestudio/nord-vim'
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'ncm2/ncm2-ultisnips'
  Plug 'SirVer/ultisnips'
  Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'cohama/lexima.vim'
  Plug 'vim-test/vim-test'
  " Plug 'ludovicchabant/vim-gutentags'
  Plug 'mattn/emmet-vim'

if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  " Plug 'kristijanhusak/defx-git'
  " Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
  " Plug 'Neevash/awesome-flutter-snippets'
  " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
endif

call plug#end()
