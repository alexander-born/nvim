return {
  { "bazelbuild/vim-bazel", dependencies = { "google/vim-maktaba" } },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.compat", { "alexander-born/cmp-bazel", dependencies = "hrsh7th/nvim-cmp" } },
    opts = {
      sources = {
        compat = { "bazel" },
      },
    },
  },
  {
    "alexander-born/bazel.nvim",
    config = function()
      -- Info: to make tab completion work copy '/etc/bash_completion.d/bazel-complete.bash' to '/etc/bash_completion.d/bazel'

      vim.g.bazel_config = vim.g.bazel_config or ""
      vim.g.bazel_cmd = "bazel"

      vim.cmd([[
        set errorformat=ERROR:\ %f:%l:%c:%m
        set errorformat+=%f:%l:%c:%m
        set errorformat+=[\ \ FAILED\ \ ]\ %m\ (%.%#

        " Ignore build output lines starting with INFO:, Loading:, or [
        set errorformat+=%-GINFO:\ %.%#
        set errorformat+=%-GLoading:\ %.%#
        set errorformat+=%-G[%.%#

        " Errorformat settings
        " * errorformat reference: http://vimdoc.sourceforge.net/htmldoc/quickfix.html#errorformat
        " * look for message without consuming: https://stackoverflow.com/a/36959245/10923940
        " * errorformat explanation: https://stackoverflow.com/a/29102995/10923940

        " Ignore this error message, it is always redundant
        " ERROR: <filename>:<line>:<col>: C++ compilation of rule '<target>' failed (Exit 1)
        set errorformat+=%-GERROR:\ %f:%l:%c:\ C++\ compilation\ of\ rule\ %m
        set errorformat+=%tRROR:\ %f:%l:%c:\ %m   " Generic bazel error handler
        set errorformat+=%tARNING:\ %f:%l:%c:\ %m " Generic bazel warning handler
        " this rule is missing dependency declarations for the following files included by '<another-filename>'
        "   '<fname-1>'
        "   '<fname-2>'
        "   ...
        set errorformat+=%Ethis\ rule\ is\ %m\ the\ following\ files\ included\ by\ \'%f\':
        set errorformat+=%C\ \ \'%m\'
        set errorformat+=%Z

        " Test failures
        set errorformat+=FAIL:\ %m\ (see\ %f)            " FAIL: <test-target> (see <test-log>)

        " test failures in async builds
        set errorformat+=%E%*[\ ]FAILED\ in%m
        set errorformat+=%C\ \ %f
        set errorformat+=%Z

        " Errors in the build stage
        set errorformat+=%f:%l:%c:\ fatal\ %trror:\ %m         " <filename>:<line>:<col>: fatal error: <message>
        set errorformat+=%f:%l:%c:\ %trror:\ %m                " <filename>:<line>:<col>: error: <message>
        set errorformat+=%f:%l:%c:\ %tarning:\ %m              " <filename>:<line>:<col>: warning: <message>
        set errorformat+=%f:%l:%c:\ note:\ %m                  " <filename>:<line>:<col>: note: <message>
        set errorformat+=%f:%l:%c:\ \ \ requ%tred\ from\ here  " <filename>:<line>:<col>: <message>
        set errorformat+=%f(%l):\ %tarning:\ %m                " <filename>(<line>): warning: <message>
        set errorformat+=%f:%l:%c:\ %m                         " <filename>:<line>:<col>: <message>
        set errorformat+=%f:%l:\ %m                            " <filename>:<line>: <message>
        ]])
    end,
  },
}
