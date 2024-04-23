return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = {
        cpp = { "clang-format" },
        lua = { "stylua" },
        python = { "black" },
        bzl = { "buildifier" },
        sh = { "shfmt" },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "stylua")
      table.insert(opts.ensure_installed, "buildifier")
      table.insert(opts.ensure_installed, "clangd")
      table.insert(opts.ensure_installed, "black")
      table.insert(opts.ensure_installed, "clang-format")
    end,
  },
}
