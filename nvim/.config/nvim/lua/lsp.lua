require'lspconfig'.gopls.setup{
    cmd = {"gopls", "-remote=auto"}
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
