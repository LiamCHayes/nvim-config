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

    -- Zen mode
    { "folke/zen-mode.nvim" },

    -- find files and grep
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- File tree explorer
    -- {
        -- 'nvim-tree/nvim-tree.lua',
        -- version="*",
        -- lazy=false,
        -- requires = { "nvim-tree/nvim-web-devicons" },
        -- config = function()
            -- require("nvim-tree").setup {}
        -- end
    -- },

    -- Directory editor
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },

    -- Undo tree
    { "mbbill/undotree", cmd = "UndotreeToggle" },

    -- Lazygit integration
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Show open buffers as tabs
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    -- Keymap help
    { "folke/which-key.nvim",
    config = function()
        require("which-key").setup({})
    end},

    -- Make jumping to places on screen easier 
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    -- VimTeX for editing and compiling LaTeX
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"  -- Or your preferred PDF viewer
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
        dependencies = {"chomosuke/typst-preview.nvim"}
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

    -- Quickfix list improvements
    {
        'stevearc/quicker.nvim',
        ft = "qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
        config = function()
            require("quicker").setup({
                keys = {
                    {
                        ">",
                        function()
                            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                        end,
                        desc = "Expand quickfix context",
                    },
                    {
                        "<",
                        function()
                            require("quicker").collapse()
                        end,
                        desc = "Collapse quickfix context",
                    },
                },
            })
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Setup language servers here

        -- Python
        lspconfig.pyright.setup{ capabilities = capabilities }

        -- Rust
        lspconfig.rust_analyzer.setup{ capabilities = capabilities }

        -- LaTeX
        lspconfig.texlab.setup{ capabilities = capabilities }

        -- C and C++
        lspconfig.clangd.setup{ capabilities = capabilities }
    end},

    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },
            signature = { enabled = true },
            completion = { documentation = { auto_show = true } },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

    {
        "olimorris/codecompanion.nvim",
        version = "^18.0.0",
        opts = {
            adapters = {
                gemini = {
                    client = {
                        model = "gemini-pro",
                    },
                    authentication = {
                        method = "oauth_personal",
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" }
    }
})
