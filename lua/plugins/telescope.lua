return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          pcall(require("telescope").load_extension, "fzf")
        end,
      },
      {
        "nvim-telescope/telescope-project.nvim",
        config = function()
          require("telescope").load_extension("project")
        end,
      },
      {
        "AckslD/nvim-neoclip.lua",
        config = function()
          require("neoclip").setup()
        end,
      },
    },
    keys = { { "<leader>sa", false } },
    opts = {
      extensions = {
        project = {
          base_dirs = { { path = "~", max_depth = 4 } },
        },
      },
    },
  },
}
