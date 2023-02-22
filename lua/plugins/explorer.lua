return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        window = {
          mappings = { ["o"] = "open", ["<leader>f"] = "telescope_find", ["<leader>s"] = "telescope_grep" },
        },
        commands = {
          telescope_find = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files({ search_dirs = { path } })
          end,
          telescope_grep = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").live_grep({ search_dirs = { path } })
          end,
        },
      },
    },
  },
}
