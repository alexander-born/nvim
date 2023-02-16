return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-project.nvim" },
      { "AckslD/nvim-neoclip.lua" },
    },
    keys = { { "<leader>sa", false } },
    opts = {
      extensions = {
        project = {
          base_dirs = { { path = "~", max_depth = 4 } },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("project")
      telescope.load_extension("fzf")
      require("neoclip").setup()
    end,
  },
}
