return {
  "nvim-treesitter/nvim-treesitter",
  ---@type TSConfig
  opts = {
    ensure_installed = {
      "bash",
      "help",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "cpp",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<leader>sa"] = "@parameter.inner" },
        swap_previous = { ["<leader>sA"] = "@parameter.inner" },
      },
    },
  },
}
