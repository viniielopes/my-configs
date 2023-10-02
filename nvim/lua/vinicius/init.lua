require("vinicius.lazy")
require("vinicius.set")
require("vinicius.remap")


-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('vinicius', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


-- Error and warning signs.
vim.g.ale_sign_error = '⤫'
vim.g.ale_sign_warning = '⚠'

vim.g.ale_fix_on_save = 1
-- g.ale_javascript_prettier_use_global = 1

vim.g.ale_linters = {
    json = {'prettier'},
    javascript = {'prettier', 'eslint'},
    typescript = {'prettier', 'eslint'},
    javascriptreact = {'prettier', 'eslint'},
    typescriptreact = {'prettier', 'eslint'}
}

vim.g.ale_fixers = {
    ['*'] = {'prettier', 'remove_trailing_lines', 'trim_whitespace'},
    json = {'prettier'},
    javascript = {'prettier', 'eslint'},
    typescript = {'prettier', 'eslint'},
    javascriptreact = {'prettier', 'eslint'},
    typescriptreact = {'prettier', 'eslint'}
}

-- disbale deno as a linter
vim.g.ale_linters_ignore = {
    typescript = {'deno'},
    typescriptreact = {'deno'},
    nix = {'nix', 'statix'}
}

-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterGreen',
        'RainbowDelimiterOrange',
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
        'RainbowDelimiterRed',
    },
}
