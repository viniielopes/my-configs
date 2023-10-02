-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        dependencies = {{'nvim-lua/plenary.nvim'}},
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        find_command = {
                            "rg", "--files", "--hidden", "--glob", "!**/.git/*"
                        }
                    }
                }
            }
        end
    }, {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function() vim.cmd('colorscheme rose-pine') end
    }, {
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("trouble").setup {
                icons = true
                -- your configuration comes here
                -- or leave it empty to  the default settings
                -- refer to the configuration section below
            }
        end
    }, {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'HiPhish/rainbow-delimiters.nvim'
        },
        build = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end
    },
    {"nvim-treesitter/nvim-treesitter-textobjects",
    dependencies={
        'nvim-treesitter'
    }},
    {"nvim-treesitter/playground"},
    {"theprimeagen/harpoon"},
    {"theprimeagen/refactoring.nvim"},
    {"mbbill/undotree"},
    {"tpope/vim-fugitive"},
    {"nvim-treesitter/nvim-treesitter-context"},
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'}, -- Autocompletion
            {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'}, -- Snippets
            {'L3MON4D3/LuaSnip'}, {'rafamadriz/friendly-snippets'}
        }
    },
    {"folke/zen-mode.nvim"},
    {"eandrju/cellular-automaton.nvim"},
    {"laytan/cloak.nvim"},
    {"dense-analysis/ale"},
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        'windwp/nvim-ts-autotag',
        branch = 'main',
        dependencies = {'nvim-treesitter/nvim-treesitter'},
        config = function() require('nvim-ts-autotag').setup() end
    },
    {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to  `main` branch for the latest features
        config = function()
            require("nvim-surround").setup {
                {
                    -- Configuration here, or leave empty to  defaults
                }
            }
        end
    },
    {'nvim-tree/nvim-web-devicons'},
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons' -- optional
        }
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'unblevable/quick-scope'
    }

}

require("lazy").setup(plugins, {})
