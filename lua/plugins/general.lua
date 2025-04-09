return {
  { "folke/lazy.nvim", opts = { checker = { notify = false } } },
  { "tpope/vim-abolish" },
  { "L3MON4D3/LuaSnip" },
  { "machakann/vim-sandwich" },
  { "mg979/vim-visual-multi" },
  { "LunarVim/bigfile.nvim" },
  { "davidgranstrom/nvim-markdown-preview" },
  {
    "gbprod/yanky.nvim",
    opts = {},
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<leader>sy",
        function()
          Snacks.picker.yanky()
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = { { ext = ".md", path = "~/projects/vimwiki/", syntax = "markdown" } }
    end,
  },
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
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()
    end,
  },
  { "snacks.nvim", opts = { notifier = { enabled = false } } },
}
