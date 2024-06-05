local path = require("lspconfig/util").path

local function bazel_root_dir(default_root_dir)
  return function(fname)
    local bazel = require("bazel")
    if bazel.is_bazel_cache(fname) then
      return bazel.get_workspace_from_cache(fname)
    elseif bazel.is_bazel_workspace(fname) then
      return bazel.get_workspace(fname)
    end

    return default_root_dir(fname)
  end
end

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local pipfile = path.join(workspace, "Pipfile")
  if vim.fn.filereadable(pipfile) == 1 then
    local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. pipfile .. " pipenv --venv"))
    if vim.v.shell_error == 0 then
      return path.join(venv, "bin", "python")
    else
      print("Virtual environment of Pipfile not yet created. To create: cd " .. workspace .. "; pipenv shell;")
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "alexander-born/bazel.nvim" },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- will be automatically installed with mason and loaded with lspconfig
        clangd = {},
        pyright = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        clangd = function(_, opts)
          opts.capabilities.documentFormattingProvider = false
          opts.capabilities.offsetEncoding = { "utf-16" }
          opts.cmd = {
            "clangd",
            "--background-index",
            "--header-insertion=never",
            -- "--clang-tidy",
            -- "--clang-tidy-checks=*",
            "--query-driver=**",
            "--compile-commands-dir=" .. vim.g.project_path or vim.fn.getcwd(),
          }
          opts.root_dir = bazel_root_dir(require("lspconfig.server_configurations.clangd").default_config.root_dir)
        end,
        pyright = function(_, opts)
          opts.on_init = function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
          end
          opts.root_dir = bazel_root_dir(require("lspconfig.server_configurations.pyright").default_config.root_dir)
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
