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
        dependencies = { { 'nvim-lua/plenary.nvim' } },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
        'HiPhish/rainbow-delimiters.nvim'
    },
    build = function()
        local ts_update = require('nvim-treesitter.install').update({
            with_sync = true
        })
        ts_update()
    end
},
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            'nvim-treesitter'
        }
    },
    { "nvim-treesitter/playground" },
    { "theprimeagen/harpoon" },
    { "theprimeagen/refactoring.nvim" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function() require('lsp-zero').extend_lspconfig() end
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('cmp').setup {
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                    -- more sources
                },
            }
        end
    },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
    { "folke/zen-mode.nvim" },
    { "eandrju/cellular-automaton.nvim" },
    { "laytan/cloak.nvim" },
    { "dense-analysis/ale" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'windwp/nvim-ts-autotag',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() require('nvim-ts-autotag').setup() end
    },
    {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to  `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                {
                    -- Configuration here, or leave empty to  defaults
                }
            }
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
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
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end

    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
        config = function()
            require('typescript-tools').setup({
                settings = {
                    tsserver_plugins = {
                        -- for TypeScript v4.9+
                        "@styled/typescript-styled-plugin",
                        -- or for older TypeScript versions
                        -- "typescript-styled-plugin",
                    },
                },
            })
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        'mhartington/formatter.nvim',
        opts = function(parser)
            if not parser then
                return {
                    exe = "./node_modules/.bin/prettier",
                    args = {
                        "--stdin-filepath",

                        vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
                    },
                    stdin = true,
                    try_node_modules = true,
                }
            end

            return {
                exe = "./node_modules/.bin/prettier",
                args = {
                    "--stdin-filepath",

                    vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
                    "--parser",
                    parser,
                },
                stdin = true,
                try_node_modules = true,
            }
        end

    },
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',


        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        end
    }
}

require("lazy").setup(plugins, {})
