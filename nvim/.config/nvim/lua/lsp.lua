local on_attach = function(client, bufnr)
    local opts = {noremap = true, silent = true}

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

require'lspconfig'.gopls.setup{
    cmd = {"gopls", "-remote=auto"};
    on_attach = on_attach;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
