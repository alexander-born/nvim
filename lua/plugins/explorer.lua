return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal_force_cwd = true })
        end,
        desc = "Explorer NeoTree Force Cwd",
      },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["o"] = "open",
            ["<leader>f"] = "telescope_find",
            ["<leader>s"] = "telescope_grep",
            ["/"] = false,
          },
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
