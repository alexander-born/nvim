local function on_project_selected(prompt_bufnr)
  local available, project_actions = pcall(require, "telescope._extensions.project.actions")
  if not available then
    return
  end
  local user_actions_available, user_project_actions = pcall(require, "user.project.actions")
  project_actions.change_working_directory(prompt_bufnr, false)
  vim.g.project_path = vim.fn.getcwd()
  if user_actions_available then
    user_project_actions(prompt_bufnr)
  end
end

local function find_project()
  local available, telescope = pcall(require, "telescope")
  if not available then
    return
  end
  telescope.extensions.project.project({
    display_type = "full",
    attach_mappings = function(prompt_bufnr, map)
      map({ "n", "i" }, "<CR>", on_project_selected)
      return true
    end,
  })
end

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
    keys = { { "<leader>fp", find_project, desc = "Find Plugin File" } },
    opts = {
      extensions = {
        project = {
          base_dirs = { { path = "~", max_depth = 4 } },
        },
      },
    },
  },
}
