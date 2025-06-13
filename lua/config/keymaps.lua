-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- stylua: ignore start
local map = vim.keymap.set

local wk = require("which-key")
wk.add( {
    { "<leader>b", group = "bazel" },
    { "<leader>bd", group = "debug" },
    { "<leader>d", group = "debug" },
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>gr", group = "grep" },
    { "<leader>s", group = "search +swap (TS)" },
    { "<leader>t", group = "test" },
    { "<leader>w", group = "wiki" },
    { "<leader>x", group = "trouble" },
  }
)

local sub = require("substitute")
map("n", "<leader>r", sub.operator, { desc = "Replace with Register" })
map("n", "<leader>rr", sub.line, { desc = "Replace Line with Register" })
map("n", "<leader>R", sub.eol, { desc = "Replace EOL with Register" })
map("x", "r", sub.visual, { desc = "Replace with Register" })

map("n", "<leader>sa", "<cmd>TSTextobjectSwapNext<CR>", { desc = "Swap Arguments" })
map("n", "<leader>sA", "<cmd>TSTextobjectSwapPrevious<CR>", { desc = "Swap Arguments Previous" })

-- bazel
local bazel = require("bazel")
local my_bazel = require("config.bazel")
-- vim.api.nvim_create_autocmd("FileType", { pattern = "bzl", callback = function() map("n", "gd", vim.fn.GoToBazelDefinition, { buffer = true, desc = "Goto Definition" }) end, })
vim.api.nvim_create_autocmd("FileType", { pattern = "bzl", callback = function() map("n", "<Leader>y", my_bazel.YankLabel, { desc = "Bazel Yank Label" }) end, })
map("n", "gbt", vim.fn.GoToBazelTarget, { desc = "Goto Bazel Build File" })
map("n", "<Leader>bl", bazel.run_last, { desc = "Bazel Last" })
map("n", "<Leader>bdt", my_bazel.DebugTest, { desc = "Bazel Debug Test" })
map("n", "<Leader>bdr", my_bazel.DebugRun, { desc = "Bazel Debug Run" })
map("n", "<Leader>bt", function() bazel.run_here("test", vim.g.bazel_config .. " --test_output=all") end, { desc = "Bazel Test" })
map("n", "<Leader>bT", function() bazel.run_here("test", vim.g.bazel_config .. " --test_output=all --test_arg=" .. require("bazel.gtest").get_gtest_filter_args()[1]) end, { desc = "Bazel Single GTest" })
map("n", "<Leader>bb", function() bazel.run_here("build", vim.g.bazel_config) end, { desc = "Bazel Build" })
map("n", "<Leader>br", function() bazel.run_here("run", vim.g.bazel_config) end, { desc = "Bazel Run" })
map("n", "<Leader>bdb", function() bazel.run_here("build", vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0") end, { desc = "Bazel Debug Build" })
map("n", "<Leader>bda", my_bazel.set_debug_args_from_input, { desc = "Set Bazel Debug Arguments" })

-- multi cursor <M-...> = <Alt-...>
map("n", "<M-j>", "<Plug>(VM-Add-Cursor-Down)", { desc = "Multi Cursor Down" })
map("n", "<M-k>", "<Plug>(VM-Add-Cursor-Up)", { desc = "Multi Cursor Up" })

-- debugger
local dap = require("dap")
local mydap = require("config.dap")
map("n", "<leader>m", ":MaximizerToggle!<CR>", { desc = "Maximize Window Toggle" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Set Breakpoint" })
map("n", "<leader>l", dap.step_into, { desc = "Step Into (debugger)" })
map("n", "<leader>j", dap.step_over, { desc = "Step Over (debugger)" })
map("n", "<leader>k", dap.step_out, { desc = "Step Out (debugger)" })
map("n", "<leader>dr", dap.run_to_cursor, { desc = "Run to Cursor" })
map("n", "<leader>dp", require("dap-python").test_method, { desc = "Debug python test_method" })
map("n", "<leader>dl", dap.run_last, { desc = "Debug Last" })
map("n", "<leader>de", mydap.end_debug_session, { desc = "End Debugger" })
map("n", "<leader>dc", ":e .vscode/launch.json<CR>", { desc = "Edit Debug Configurations" })
map("n", "<leader>d<space>", dap.continue, { desc = "Continue (debugger)" })

-- git
map("n", "<Leader>gl", ":G log -n 1000<CR>", { desc = "Git Log" })
map("n", "<Leader>gd", ":GitDiff<CR>", { desc = "Git Diff" })
map("n", "<Leader>gs", ":G<CR>", { desc = "Git Status" })
map("n", "<Leader>gp", ":G push<CR>", { desc = "Git Push" })
map("n", "<Leader>gP", ":G push --force-with-lease<CR>", { desc = "Git Push --force-with-lease" })
map("v", "<Leader>gb", ":GBrowse<CR>", { desc = "Git Browse" })

-- easy navigation between window splits and tmux panes
local tmux = require("tmux")
map("n", "<C-J>", tmux.move_bottom, { desc = "Window <down>" })
map("n", "<C-K>", tmux.move_top, { desc = "Window <up>" })
map("n", "<C-L>", tmux.move_right, { desc = "Window <right>" })
map("n", "<C-H>", tmux.move_left, { desc = "Window <left>" })

map("v", "<C-c>", '"+y', { desc = "CTRL-c copies selection" })

-- beginning/end of line
map({ "n", "v" }, "H", "^", { desc = "Beginning of Line" })
map({ "n", "v" }, "L", "$", { desc = "End of Line" })

-- neotest
local neotest = require("neotest")
map("n", "<leader>to", neotest.output.open, { desc = "Toggle Test Output" })
map("n", "<leader>tt", neotest.run.run, { desc = "Test Nearest Test" })
map("n", "<leader>tl", neotest.run.run_last, { desc = "Test Last" })
map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test File" })
map("n", "<leader>tdt", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Test Debug Nearest Test" })
map("n", "<leader>tdf", function() neotest.run.run({ vim.fn.expand("%"), strategy = "dap" }) end, { desc = "Test Debug File" })

-- wiki
map("n", "<leader>ww", ":VimwikiIndex<CR>", { desc = "Open Wiki Index" })

-- switch between cpp and header file
map('n', '<F7>', ":ClangdSwitchSourceHeader<CR>", {desc = "Switch Source/Header"})

-- stylua: ignore end
