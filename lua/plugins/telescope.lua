return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-project.nvim" },
      { "AckslD/nvim-neoclip.lua" },
    },
    keys = { { "<leader>sa", false } },
    opts = function()
      local custom_pickers = require("config.telescope_custom_pickers")
      return {
        pickers = {
          live_grep = {
            mappings = {
              i = {
                ["<c-f>"] = custom_pickers.actions.set_extension,
                ["<c-l>"] = custom_pickers.actions.set_folders,
              },
            },
          },
        },
        extensions = {
          project = {
            base_dirs = { { path = "~", max_depth = 4 } },
            on_project_selected = function(prompt_bufnr)
              local project_actions = require("telescope._extensions.project.actions")
              local user_actions_available, user_project_actions = pcall(require, "user.project.actions")
              local work_actions_available, work_project_actions = pcall(require, "work.project.actions")
              project_actions.change_working_directory(prompt_bufnr, false)
              vim.g.project_path = vim.fn.getcwd()
              if user_actions_available then
                user_project_actions(prompt_bufnr)
              end
              if work_actions_available then
                work_project_actions(prompt_bufnr)
              end
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("project")
      require("neoclip").setup()
    end,
  },
}
