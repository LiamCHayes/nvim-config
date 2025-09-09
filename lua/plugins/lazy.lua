local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Color setup
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- find files and grep
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- File tree explorer
    { 'nvim-tree/nvim-tree.lua', version="*", lazy=false, 
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup {}
    end},

    -- Show open buffers as tabs
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    -- Keymap help
    { "folke/which-key.nvim",
    config = function()
        require("which-key").setup({})
    end},

    -- VimTeX for editing and compiling LaTeX
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"  -- Or your preferred PDF viewer
        end
    },

    -- LaTeX snippets for nvim-cmp (requires LuaSnip)
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "saadparwaiz1/cmp_luasnip" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    -- Typst LSP
    {
        "nvim-lspconfig",
        dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            -- Existing servers
            lspconfig.pyright.setup {}
            lspconfig.rust_analyzer.setup {}
            lspconfig.texlab.setup {}

            -- Typst via tinymist LSP
            lspconfig.tinymist.setup {
                settings = {
                    exportPdf = "onSave",   -- Options: "onType" | "onSave"
                }
            }
        end,
    },

    -- Typst preview
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        build = function()
            require("typst-preview").update()
        end,
        config = function()
            require("typst-preview").setup({
                -- Customize preview settings as needed
                follow_cursor = true,
                invert_colors = "auto",
            })
        end,
    },

    -- treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "lua", "rust", "python", "latex", "typst" },
                highlight = { enable = true },
            }
        end,
    },

    -- lsp config
    {'mason-org/mason.nvim', tag = 'v1.11.0', pin = true, 
    config = function()
        require("mason").setup()
    end},
    {'mason-org/mason-lspconfig.nvim', tag = 'v1.32.0', pin = true},
    {'neovim/nvim-lspconfig', tag = 'v1.8.0', pin = true, 
    config = function()
        local lspconfig = require('lspconfig')
        -- Setup language servers here

        -- Python
        lspconfig.pyright.setup{}

        -- Rust
        lspconfig.rust_analyzer.setup{}

        -- LaTeX
        lspconfig.texlab.setup{}
    end},
    {'hrsh7th/cmp-nvim-lsp'},  -- LSP completions source for nvim-cmp
    {'hrsh7th/nvim-cmp'},      -- Autocompletion plugin
})

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            -- You can use either LuaSnip or other snippet engines here
            -- For now, leave empty or add your snippet expand function.
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),      -- Ctrl+n to select next item
        ['<C-p>'] = cmp.mapping.select_prev_item(),      -- Ctrl+p to select previous item
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter confirms selection
        ['<C-Space>'] = cmp.mapping.complete(),          -- Ctrl+Space to trigger completion manually
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },   -- LSP completions source
        -- Add other sources here, e.g., buffer, path, etc.
    }),
})
