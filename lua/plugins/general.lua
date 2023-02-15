return {
    {
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup()
        end
    },
    { "tpope/vim-abolish" },
    { "mg979/vim-visual-multi" },
    {
        "vimwiki/vimwiki",
        config = function()
            require("config.vimwiki").setup()
        end,
    },
    { "davidgranstrom/nvim-markdown-preview" },
    { "aserowy/tmux.nvim",
        config = function() return require("tmux").setup() end
    },
}
