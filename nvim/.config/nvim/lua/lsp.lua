local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
    local opts = {noremap = true, silent = true}

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>si', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    vim.api.nvim_command('autocmd CursorHoldI <buffer=' .. bufnr .. '> lua vim.lsp.buf.signature_help()')
end

lspconfig.gopls.setup{
    cmd = {"gopls", "-remote=auto"},
    on_attach = on_attach,
    root_dir = function()
        return vim.fn.getcwd()
    end,
}

lspconfig.pyright.setup{
    on_attach = on_attach,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                diagnosticMode = 'workspace',
            },
            linting = {
                enabled = false,
            },
        },
    },
}

local vista_executive_for = vim.g.vista_executive_for
vista_executive_for.go = 'nvim_lsp'
vim.g.vista_executive_for = vista_executive_for

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
    }
)
