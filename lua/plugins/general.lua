return {
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  },
  { "tpope/vim-abolish" },
  { "mg979/vim-visual-multi" },
  {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list =
        { {
          ext = ".md",
          path = "~/projects/vimwiki/",
          syntax = "markdown",
        } }
    end,
  },
  { "davidgranstrom/nvim-markdown-preview" },
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({ copy_sync = { enable = false } })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  { "machakann/vim-sandwich" },
}
