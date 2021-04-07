local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.history = 5000

vim.cmd [[
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent]]

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.termguicolors = true
vim.wo.nu = true
vim.wo.rnu = true

return require("packer").startup(
function()
    use "wbthomason/packer.nvim"
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf", opt = true},
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>ff", ":Files<CR>", {noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>fb", ":Buffers<CR>", {noremap = true})
        end
    }
    use {
        "lervag/vimtex",
        ft = {"tex"},
        config = [[vim.g.vimtex_view_method = 'zathura']]
    }
    --use {
        --    "gruvbox-community/gruvbox",
        --    config = [[vim.cmd('colorscheme gruvbox')]]
        --}
        use {
            "dracula/vim",
            config = [[vim.cmd('colorscheme dracula')]]
        }
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true},
            config = function()
                require("lualine").setup {
                    options = {
                        theme = "dracula",
                        section_separators = {"", ""},
                        component_separators = {"", ""},
                        icons_enabled = true
                    },
                    sections = {
                        lualine_a = {{"mode", upper = true}},
                        lualine_b = {{"branch", icon = ""}},
                        lualine_c = {{"filename", file_status = true}},
                        lualine_x = {"encoding", "fileformat", "filetype"},
                        lualine_y = {"progress"},
                        lualine_z = {"location"}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {"filename"},
                        lualine_x = {"location"},
                        lualine_y = {},
                        lualine_z = {}
                    },
                    extensions = {"fzf"}
                }
            end
        }

        use {
            "hrsh7th/nvim-compe",
            config = function()
                vim.o.completeopt = "menuone,noselect"
                require("compe").setup {
                    enabled = true,
                    autocomplete = true,
                    debug = false,
                    min_length = 1,
                    preselect = "enable",
                    throttle_time = 80,
                    source_timeout = 200,
                    incomplete_delay = 400,
                    max_abbr_width = 100,
                    max_kind_width = 100,
                    max_menu_width = 100,
                    documentation = true,
                    source = {
                        path = true,
                        buffer = true,
                        calc = true,
                        nvim_lsp = true,
                        nvim_lua = true,
                        vsnip = true
                    }
                }
            end
        }
        use 'sbdchd/neoformat'
        use 'LnL7/vim-nix'
        use { 
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config=function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = { "lua", "c", "cpp", "python", "latex" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                    highlight = {
                        enable = true,              -- false will disable the whole extension
                    },
                }
            end
        }
    end
    )
