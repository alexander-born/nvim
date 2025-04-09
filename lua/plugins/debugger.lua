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
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("dap")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "cpptools")
      table.insert(opts.ensure_installed, "debugpy")
    end,
  },
}
