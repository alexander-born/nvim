return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_c[4] = {
        function()
          return vim.fn.expand("%:.")
        end,
      }
    end,
  },
}
