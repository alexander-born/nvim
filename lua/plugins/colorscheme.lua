return {
  {
    "sainnhe/everforest",
    config = function()
      require("config.everforest").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
