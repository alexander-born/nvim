-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
pcall(require, "work")
pcall(require, "user")
