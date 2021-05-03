local on_attach = function(client, bufnr)
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
