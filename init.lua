keymap = vim.keymap
set = vim.opt
augroup = vim.api.nvim_create_augroup
autocmd = vim.api.nvim_create_autocmd

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    {'preservim/nerdtree'},
    {'vim-jp/vimdoc-ja'},
    {'itchyny/lightline.vim'},
    {'nanotech/jellybeans.vim'},
    {'cohama/lexima.vim'},
    {'preservim/nerdtree'},
    {'junegunn/fzf', build="./install --bin"},
    {'junegunn/fzf.vim'},
    {'tpope/vim-fugitive'},
    {'tpope/vim-surround'},
}

--keybinds
--normal
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')
keymap.set('n', 'gj', 'j')
keymap.set('n', 'gk', 'k')
keymap.set('n', '<C-j>', '<C-e>')
keymap.set('n', '<C-k>', '<C-y>')
keymap.set('n', '<C-n>', '<cmd>NERDTreeToggle<CR>')
keymap.set('n', '<ESC><ESC>', '<cmd>nohlsearch<CR>')
keymap.set('n', '<Up>', '<cmd>bnext<CR>')
keymap.set('n', '<Down>', '<cmd>bprevious<CR>')
keymap.set('n', 'ZZ', '<Nop>')
keymap.set('n', 'ZQ', '<Nop>')

tab_prefix = '<S-t>'
keymap.set('n', tab_prefix, '<Nop>')
keymap.set('n', tab_prefix..'n', '<cmd>tabnew<CR>')
keymap.set('n', tab_prefix..'e', '<cmd>tabedit<CR>')
keymap.set('n', tab_prefix..'q', '<cmd>tabclose<CR>')
keymap.set('n', tab_prefix..'l', '<cmd>tabnext<CR>')
keymap.set('n', tab_prefix..'h', '<cmd>tabprevious<CR>')
keymap.set('n', tab_prefix..'S-l', '<cmd>+tabmove<CR>')
keymap.set('n', tab_prefix..'S-h', '<cmd>-tabmove<CR>')

--insert
keymap.set('i', '<C-b>', '<Left>')
keymap.set('i', '<C-f>', '<Right>')

--visual
keymap.set('v', '<C-j>', '<C-e>')
keymap.set('v', '<C-k>', '<C-y>')

--command
keymap.set('c', '<C-p>', '<C-r>')
keymap.set('c', '<C-f>', '<Right>')
keymap.set('c', '<C-b>', '<Left>')

--terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>')

set.helplang = "ja", "en"
set.mouse = ""
set.showtabline = 4
set.tabstop   = 4
set.expandtab = true
set.shiftwidth = 4
set.autoindent = true
set.smartindent = true

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '',
    command = 'startinsert'
})
