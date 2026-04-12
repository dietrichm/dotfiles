local augroup = vim.api.nvim_create_augroup('dotfiles_autocmds', { clear = true })

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function(ev)
    local name, kind, active = ev.data.spec.name, ev.data.kind, ev.data.active
    if name == 'nvim-treesitter' and kind == 'update' then
      if not active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(args)
    local client_id, buf = args.data.client_id, args.buf
    local client = assert(vim.lsp.get_client_by_id(client_id))
    vim.lsp.completion.enable(true, client_id, buf, {
      autotrigger = true,
      convert = function(item)
        return {
          abbr = item.label:gsub('%b()', ''),
          menu = '',
        }
      end,
    })
    vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buf = buf })
    vim.notify_once(('✅ %s attached'):format(client.name), vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'grep',
  group = augroup,
  command = [[botright cwindow]],
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lgrep',
  group = augroup,
  command = [[lwindow]],
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'lmake',
  group = augroup,
  callback = function()
    vim.cmd([[
      lwindow
      if getloclist(0, {'size': 1}).size == 0
        unsilent echomsg "✅ No errors"
      endif
    ]])
  end,
})

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup,
  callback = function()
    vim.hl.on_yank {
      higroup = 'Visual',
      timeout = 500,
      on_visual = false,
    }
  end,
})
