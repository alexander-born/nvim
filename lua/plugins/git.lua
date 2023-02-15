return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },
  { "tpope/vim-rhubarb" },
  {
    "rhysd/conflict-marker.vim",
    config = function()
      require("config.conflict_marker").setup()
    end,
  },
}
