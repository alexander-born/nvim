-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

vim.cmd([[
function! OpenErrorInQuickfix()
    cexpr []
    caddexpr getline(0,'$')
    copen
    let l:qf_list = []
    for entry in getqflist()
        if (entry.valid == 1) 
            if (entry.bufnr !=0)
                call add(l:qf_list, entry)
            endif
        endif
    endfor
    call setqflist(l:qf_list)
endfunction
]])

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup("term_mapping"),
  callback = function()
    vim.keymap.set("n", "<Leader>e", vim.fn.OpenErrorInQuickfix, { desc = "Errors to Quickfix", buffer = true })
  end,
})

vim.cmd(
  [[command! SetupPyrightWithBazelForThisTarget execute "lua require'config.bazel'.setup_pyright_with_bazel_for_this_target()"]]
)

function UpdateConfig()
  vim.cmd("!git -C ~/.config/nvim checkout lazy-lock.json")
  vim.cmd("!git -C ~/.config/nvim pull")
  vim.cmd("!git -C ~/.config/nvim/lua/work pull")
  vim.cmd("Lazy restore")
end

vim.cmd([[command! UpdateConfig lua UpdateConfig()]])
