-- stylua: ignore
return {
  { "folke/lazy.nvim", opts = { checker = { notify = false } } },
  { "tpope/vim-abolish" },
  { "machakann/vim-sandwich" },
  { "mg979/vim-visual-multi" },
  { "davidgranstrom/nvim-markdown-preview" },
  { "vimwiki/vimwiki", config = function() vim.g.vimwiki_list = { { ext = ".md", path = "~/projects/vimwiki/", syntax = "markdown", } } end, },
  { "aserowy/tmux.nvim", config = function() return require("tmux").setup({ copy_sync = { enable = false } }) end, },
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end, },
  { "gbprod/substitute.nvim", config = function() require("substitute").setup() end },
}
