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
      -- disable the default highlight group
      vim.g.conflict_marker_highlight_group = ""

      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = "^<<<<<<< .*$"
      vim.g.conflict_marker_end = "^>>>>>>> .*$"

      vim.cmd([[
        hi ConflictMarkerBegin guibg=#2f7366
        hi ConflictMarkerOurs guibg=#2e5049
        hi ConflictMarkerTheirs guibg=#344f69
        hi ConflictMarkerEnd guibg=#2f628e
        hi ConflictMarkerCommonAncestorsHunk guibg=#754a81
      ]])
    end,
  },
}
