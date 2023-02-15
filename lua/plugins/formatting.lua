local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name ~= "clangd" and client.name ~= "lua_ls"
        end,
        bufnr = bufnr,
        timeout_ms = 2000,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
            local null_ls = require("null-ls")
            return {
                sources = {
                    -- null_ls.builtins.formatting.black,
                    -- null_ls.builtins.formatting.isort,
                    -- null_ls.builtins.formatting.autoflake,
                    -- null_ls.builtins.formatting.buildifier,
                    -- null_ls.builtins.formatting.clang_format,
                    -- null_ls.builtins.formatting.json_tool,
                    -- null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.stylua,
                },
                -- on_attach = on_attach,
            }
        end,
    },
}
