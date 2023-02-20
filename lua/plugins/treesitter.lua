return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", init = function() end },
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "cpp")
    opts.textobjects = {
      swap = {
        enable = true,
        swap_next = { ["<leader>sa"] = "@parameter.inner" },
        swap_previous = { ["<leader>sA"] = "@parameter.inner" },
      },
    }
  end,
}
