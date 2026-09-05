vim.g.mapleader = '\\'
vim.g.maplocalleader = ','

vim.opt.clipboard:append('unnamedplus')
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true

local github = function(repository)
  return 'https://github.com/' .. repository
end

vim.pack.add({
  github('editorconfig/editorconfig-vim'),
  github('nvim-lualine/lualine.nvim'),
  github('rebelot/kanagawa.nvim'),
  github('ibhagwan/fzf-lua'),
  github('tpope/vim-commentary'),
  github('tpope/vim-repeat'),
  github('tpope/vim-surround'),
})

local fzf = require('fzf-lua')
fzf.setup({})

local map = vim.keymap.set
local config_path = vim.fn.stdpath('config') .. '/init.lua'

map('n', '<C-S>', '<Cmd>suspend<CR>')
map('n', '<Leader>v', '<Cmd>vsplit ' .. vim.fn.fnameescape(config_path) .. '<CR>', { silent = true })
map('n', '<Leader>s', function()
  vim.cmd.source(config_path)
  vim.notify('init.lua reloaded')
end, { silent = true })

if vim.fn.maparg('<C-L>', 'n') == '' then
  map('n', '<C-L>', '<Cmd>nohlsearch<CR><C-L>', { silent = true })
end

map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '*', '*zz')
map('n', '#', '#zz')
map('n', 'g*', 'g*zz')
map('n', 'g#', 'g#zz')
map({ 'n', 'v' }, ';', ':')
map({ 'n', 'v' }, ':', ';')

map('n', '[FZF]', '<Nop>')
map('n', '<Space>', '[FZF]', { remap = true })
map('n', '[FZF]b', fzf.buffers)
map('n', '[FZF]x', fzf.commands)
map('n', '[FZF]f', function()
  fzf.files({ cwd = vim.fn.expand('%:p:h') })
end)
map('n', '[FZF]e', function()
  fzf.files({ cwd = vim.fn.getcwd() })
end)
map('n', '[FZF]p', fzf.git_files)
map('n', '[FZF]k', '<Cmd>bd<CR>')
map('n', '[FZF]l', fzf.blines)
map('n', '[FZF]r', fzf.oldfiles)
map('n', '[FZF]<Space>', fzf.buffers)

vim.api.nvim_create_user_command('Rg', function(opts)
  fzf.live_grep({
    search = opts.args,
    winopts = {
      fullscreen = opts.bang,
      preview = {
        hidden = not opts.bang,
        layout = opts.bang and 'vertical' or 'horizontal',
        vertical = 'up:60%',
        horizontal = 'right:50%',
      },
    },
    keymap = { builtin = { ['?'] = 'toggle-preview' } },
  })
end, { bang = true, nargs = '*', force = true })

map('n', '[FZF]a', '<Cmd>Rg<CR>')

vim.cmd.colorscheme('kanagawa')
require('lualine').setup({
  options = { theme = 'kanagawa' },
})

if vim.fn.has('gui_vimr') == 1 then
  map('n', '<D-Right>', '<Cmd>tabnext<CR>')
  map('n', '<D-Left>', '<Cmd>tabprevious<CR>')
end
