return {
  "sainnhe/everforest",
  config = function()
    require("config.everforest").setup()
  end,
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
