-- This file can be loaded by calling `lua require('plugins')` from ~/.config/nvim/init.vim

-- Collect packer.nvim if not found.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

packer = require("packer")
packer.init {
    ensure_dependencies = false, -- should packer install plugin dependencies
    opt_default = false, -- default to using opt (as opposed to start) plugins
    display = {
        open_fn = nil,
        show_all_info = true,
    },
}
packer.reset()
return packer.startup(function()
    use "wbthomason/packer.nvim" -- package manager itself
    -- Editor
    use "preservim/nerdtree" -- filesystem viewer pane
    use "mg979/vim-visual-multi" -- multi-line editing
    use "jiangmiao/auto-pairs" -- match closing brackets
    use "Mofiqul/vscode.nvim" -- colorscheme
    -- Code completion
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use {
        "ms-jpq/coq_nvim",
        branch = "coq"
    }
    use {
        "ms-jpq/coq.artifacts",
        branch = "artifacts"
    }
    use {
        "ms-jpq/coq.thirdparty",
        branch = "3p",
    }
    -- Indexing
    use "ludovicchabant/vim-gutentags" -- refreshes ctags
    use "neovim/nvim-lspconfig" -- Configurations for Nvim LSP
    -- Telescope
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope-fzf-native.nvim"
    use "BurntSushi/ripgrep"
    use "sharkdp/fd"
    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
