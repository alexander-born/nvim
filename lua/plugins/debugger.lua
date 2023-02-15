local telescope = require("telescope")
return {
  { "szw/vim-maximizer" },
  { "rcarriga/nvim-dap-ui" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("config.dap").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup()
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      telescope.load_extension("dap")
    end,
  },
}
