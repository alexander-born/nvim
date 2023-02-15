return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
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
    opts = {
      extensions = {
        project = {
          base_dirs = { { path = "~", max_depth = 4 } },
        },
      },
    },
  },
}
