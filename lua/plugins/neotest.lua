return {
  {
    "nvim-neotest/neotest",
    dependencies = { "antoinemadec/FixCursorHold.nvim", "nvim-neotest/neotest-python", "nvim-neotest/nvim-nio" },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = { require("neotest-python") },
        discovery = { enabled = false },
      })
    end,
  },
}
