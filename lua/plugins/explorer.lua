return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        formatters = {
          file = {
            truncate = 9999,
          },
        },
        layout = {
          layout = {
            width = 0.9,
            height = 0.9,
          },
          preset = function()
            return "vertical"
          end,
        },
        sources = {
          explorer = {
            layout = {
              layout = {
                width = 0.2,
              },
            },
            win = {
              list = {
                keys = {
                  ["<leader>s"] = "picker_grep",
                  ["<leader>f"] = "picker_files",
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>fe",
        function()
          local function startsWith(path, prefix)
            return path:sub(1, #prefix) == prefix
          end
          local root = LazyVim.root()
          local parent_path_buffer = vim.fn.expand("%:p:h")
          if not startsWith(parent_path_buffer, root) then
            root = parent_path_buffer
          end
          Snacks.explorer({ cwd = root })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
      { "<leader>fo", "<leader>fr", desc = "Find Recent", remap = true },
      { "<leader>fO", "<leader>fR", desc = "Find Recent - cwd", remap = true },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find files",
        remap = true,
      },
    },
  },
}
