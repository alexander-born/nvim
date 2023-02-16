local bazel = require("bazel")

local M = {}

local function StartDebugger(type, program, args, cwd, env, workspace)
  require("dap").run({
    name = "Launch",
    type = type,
    request = "launch",
    program = function()
      return program
    end,
    env = env,
    args = args,
    cwd = cwd,
    runInTerminal = false,
    stopOnEntry = false,
    setupCommands = { { text = "-enable-pretty-printing", ignoreFailures = true } },
    sourceFileMap = { ["/proc/self/cwd"] = workspace },
  })
end

function M.YankLabel()
  local label = vim.fn.GetLabel()
  print("yanking " .. label .. ' to + and " register')
  vim.fn.setreg("+", label)
  vim.fn.setreg('"', label)
end

local function get_python_imports(program)
  local command = "grep 'python_imports =' " .. program .. [[ | sed "s|.*'\(.*\)'|\1|"]]
  return vim.fn.trim(vim.fn.system(command))
end

local function get_python_test_executable(bazel_info)
  local command = [[grep -oP "rel_path = '.*'" ]]
    .. bazel_info.executable
    .. [[ | grep -o "'.*'" | tail -c +2 | head -c -2]]
  return bazel_info.runfiles .. "/" .. vim.fn.trim(vim.fn.system(command))
end

local function get_bazel_python_modules(program)
  local runfiles = program .. ".runfiles"
  local extra_paths = { runfiles, BufDir(), runfiles .. "/" .. bazel.get_workspace_name() }
  local imports = Split(get_python_imports(program), ":")
  for _, import in pairs(imports) do
    table.insert(extra_paths, runfiles .. "/" .. import)
  end
  return extra_paths
end

local function get_python_path(program)
  local extra_paths = get_bazel_python_modules(program)
  local env = ""
  local sep = ""
  for _, extra_path in pairs(extra_paths) do
    env = env .. sep .. extra_path
    sep = ":"
  end
  return env
end

local function setup_pyright(extra_paths)
  local config = { capabilities = require("config.lsp").get_capabilities() }
  config.settings = { python = { analysis = { extraPaths = extra_paths } } }
  require("lspconfig")["pyright"].setup(config)
end

local function add_python_deps_to_pyright(target, workspace)
  local query = "bazel cquery "
    .. vim.g.bazel_config
    .. " '"
    .. target
    .. "' --output starlark --starlark:expr='providers(target)[\"PyInfo\"].imports'"

  local ws_name = bazel.get_workspace_name(workspace)
  local function parse_and_add_extra_path(_, stdout)
    -- local extra_paths = {workspace}
    local extra_paths = {}
    local query_output = stdout[1]
    local depset = query_output:match("depset%(%[(.*)%]")
    if depset == nil then
      return
    end
    for extra_path in depset:gmatch('"(.-)"') do
      if extra_path:match("^" .. ws_name) then
        -- local path = extra_path:gsub("^" .. ws_name, workspace .. "/bazel-bin")
        local path = extra_path:gsub("^" .. ws_name, workspace)
        table.insert(extra_paths, path)
      else
        table.insert(extra_paths, workspace .. "/external/" .. extra_path)
      end
    end
    vim.pretty_print(extra_paths)
    setup_pyright(extra_paths)
  end

  vim.fn.jobstart(query, { on_stdout = parse_and_add_extra_path })
end

function M.setup_pyright_with_bazel_for_this_target()
  local workspace = bazel.get_workspace()
  vim.fn.BazelGetCurrentBufTarget()
  add_python_deps_to_pyright(vim.g.current_bazel_target, workspace)
end

function M.DebugBazel(type, bazel_config, get_program, args, get_env)
  local start_debugger = function(bazel_info)
    local cwd = bazel_info.runfiles .. "/" .. bazel_info.workspace_name
    StartDebugger(type, get_program(bazel_info), args, cwd, get_env(bazel_info), bazel_info.workspace)
  end
  bazel.run_here("build", bazel_config, { on_success = start_debugger })
end

function M.DebugBazelPy(get_program)
  local args = vim.g.debug_args or { "" }
  local get_env = function(bazel_info)
    return { PYTHONPATH = get_python_path(bazel_info.executable), RUNFILES_DIR = bazel_info.runfiles }
  end
  M.DebugBazel("python", vim.g.bazel_config, get_program, args, get_env)
end

function M.DebugPythonBinary()
  M.DebugBazelPy(function(_)
    return "${file}"
  end)
end

function M.DebugPytest()
  M.DebugBazelPy(function(bazel_info)
    return get_python_test_executable(bazel_info)
  end)
end

local function default_program(bazel_info)
  return bazel_info.executable
end

local function default_env(_)
  return {}
end

function M.DebugGTest()
  local args = { "--gtest_filter=" .. bazel.get_gtest_filter() }
  M.DebugBazel("cppdbg", vim.g.bazel_config .. " --compilation_mode dbg --copt -O0", default_program, args, default_env)
end

function M.DebugTest()
  if vim.bo.filetype == "python" then
    M.DebugPytest()
  elseif vim.bo.filetype == "cpp" then
    M.DebugGTest()
  else
    print("Debugging not supported for this filetype")
  end
end

function M.DebugRun()
  if vim.bo.filetype == "python" then
    M.DebugPythonBinary()
  else
    local args = vim.g.debug_args or {}
    M.DebugBazel(
      "cppdbg",
      vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0",
      default_program,
      args,
      default_env
    )
  end
end

return M
