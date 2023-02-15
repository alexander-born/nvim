local telescope = require("telescope")

local function on_project_selected(prompt_bufnr)
    local project_actions = require("telescope._extensions.project.actions")
    local user_actions_available, user_project_actions = pcall(require, "user.project.actions")
    project_actions.change_working_directory(prompt_bufnr, false)
    vim.g.project_path = vim.fn.getcwd()
    if user_actions_available then
        user_project_actions(prompt_bufnr)
    end
end

local M = {}

function M.find()
    telescope.extensions.project.project({
        display_type = "full",
        attach_mappings = function(prompt_bufnr, map)
            map({ "n", "i" }, "<CR>", on_project_selected)
            return true
        end,
    })
end

return M
