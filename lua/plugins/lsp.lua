local path = require("lspconfig/util").path

local function bazel_root_dir(bufnr, on_dir)
  local bazel = require("bazel")
  local fname = vim.fn.bufname(bufnr)
  if bazel.is_bazel_cache(fname) then
    on_dir(bazel.get_workspace_from_cache(fname))
  elseif bazel.is_bazel_workspace(fname) then
    on_dir(bazel.get_workspace(fname))
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
    opts = {
      format = {
        timeout_ms = 2000,
      },
      servers = {
        -- will be automatically installed with mason and loaded with lspconfig
        clangd = {
          cmd = function(dispatchers, config)
            local local_cmd = {
              "clangd",
              "--background-index",
              "--header-insertion=never",
              "--query-driver=**",
              "--compile-commands-dir=" .. config.root_dir,
            }
            return vim.lsp.rpc.start(local_cmd, dispatchers)
          end,
          root_dir = bazel_root_dir,
        },
        pyright = {
          root_dir = bazel_root_dir,
        },
        starpls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
      setup = {
        -- starpls = function(_, opts)
        --   opts.cmd =
        --     { "starpls", "server", "--experimental_enable_label_completions", "--experimental_infer_ctx_attributes" }
        -- end,
        -- pyright = function(_, opts)
        --   opts.on_init = function(client)
        --     client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        --   end
        --   opts.root_dir = bazel_root_dir(require("lspconfig.configs.pyright").default_config.root_dir)
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
