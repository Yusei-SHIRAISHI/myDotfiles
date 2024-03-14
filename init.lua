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
    {'nanotech/jellybeans.vim'},
    {'cohama/lexima.vim'},
    {'preservim/nerdtree'},
    {'junegunn/fzf', build="./install --bin"},
    {'junegunn/fzf.vim'},
    {'tpope/vim-fugitive'},
    {'tpope/vim-surround'},
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'prabirshrestha/vim-lsp' },
    {'mattn/vim-lsp-settings'},
    {'prabirshrestha/asyncomplete.vim'},
    {'prabirshrestha/asyncomplete-lsp.vim'},
    {'mattn/vim-lsp-icons'},
    {'hrsh7th/vim-vsnip'},
    {'github/copilot.vim'},
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        branch = "canary",
        dependencies = {
          { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
          { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
          debug = true, -- Enable debugging
          -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
  }
}

require('lualine').setup {
    options = { theme = 'jellybeans'}
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
keymap.set('n', '<C-i>', '<cmd>LspDefinition<CR>')
keymap.set('n', 'f', '<cmd>LspHober<CR>')
keymap.set('n', 'F', '<cmd>LspReference<CR>')

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
keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')
keymap.set('i', '<C-w>', '<Plug>(copilot-accept-word)')
keymap.set('i', '<C-l>', '<Plug>(copilot-accept-line)')
keymap.set('i', '<C-r>', '<Plug>(copilot-dismiss)')
keymap.set('i', '<C-r><C-r>', '<Plug>(copilot-suggest)')

--visual
keymap.set('v', '<C-j>', '<C-e>')
keymap.set('v', '<C-k>', '<C-y>')

--command
keymap.set('c', '<C-p>', '<C-r>')
keymap.set('c', '<C-f>', '<Right>')
keymap.set('c', '<C-b>', '<Left>')

--terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>')

set.laststatus = 2
set.title = true
set.showmode = true
set.number = true
set.cursorline = true
set.undofile = true
set.helplang = "ja", "en"
set.showmatch = true
set.mouse = ""
set.showtabline = 4
set.tabstop   = 4
set.expandtab = true
set.shiftwidth = 4
set.autoindent = true
set.smartindent = true
set.diffopt = 'vertical'
set.showcmd = true
set.ignorecase = true
set.smartcase = true
set.ambiwidth = 'double'
set.wildmenu = true
set.wildmode = 'longest', 'full'
set.wrapscan = true
set.hlsearch = true
set.incsearch = true
set.clipboard = 'unnamed'
set.ruler = true
set.pumheight = 10
set.infercase = true

vim.cmd[[colorscheme jellybeans]]

local term_open = augroup("term_open", { clear = true })
autocmd('TermOpen', {
    group = term_open,
    pattern = '',
    command = 'startinsert'
})
autocmd('TermOpen', {
    group = term_open,
    pattern = '*',
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})

-- 全角スペースのハイライト設定
vim.api.nvim_set_hl(0, "FullWidthSpace", {
    underline = true,
    cterm = underline,
    ctermfg = 199,
    gui = underline,
    guifg = White,
})
local full_width_space = augroup("full_width_space", { clear = true })
autocmd({"VimEnter", "WinEnter"}, {
    group = full_width_space,
    pattern = "*",
    callback = function()
        vim.fn.matchadd('FullWidthSpace', '　')
    end
})

-- 末尾スペースのハイライト設定
vim.api.nvim_set_hl(0, "EndSpace", {
    ctermbg = 199,
    guibg = Cyan,
})
local end_space = augroup("end_space", { clear = true })
autocmd({"VimEnter", "WinEnter"}, {
    group = end_space,
    pattern = "*",
    callback = function()
        vim.fn.matchadd('EndSpace', "\\s\\+$")
    end
})

-- Custom command
vim.api.nvim_create_user_command(
    'Sjis',
    function()
        vim.cmd('edit ++enc=cp932')
    end,
    {}
)
vim.api.nvim_create_user_command(
    'Utf8',
    function()
        vim.cmd('edit ++enc=utf-8')
    end,
    {}
)
vim.api.nvim_create_user_command(
    'CC',
    function()
        vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
    end,
    {}
)

local function to_snake_case(str)
    return str:gsub("(%l)(%u)", "%1_%2"):gsub("%s+", "_"):lower()
end

local function to_pascal_case(str)
    return (str:gsub("[%s_]+", " "):gsub("%f[%a]%a+", function(word)
        return word:sub(1,1):upper()..word:sub(2):lower()
    end):gsub("%s+", ""))
end

local function convert_selection_to_case(case_converter)
    -- 選択範囲を取得
    local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

    -- 選択範囲が複数行にわたる場合の処理
    local lines = vim.api.nvim_buf_get_lines(0, csrow-1, cerow, false)
    if #lines == 1 then
        -- 単一行の場合
        lines[1] = lines[1]:sub(cscol, cecol)
    else
        -- 複数行の場合
        lines[1] = lines[1]:sub(cscol)
        lines[#lines] = lines[#lines]:sub(1, cecol)
    end
    local selection = table.concat(lines, "\n")

    -- ケース変換
    local converted_str = case_converter(selection)

    -- 選択範囲を変換後の文字列で置換
    if #lines == 1 then
        -- 単一行の場合
        vim.api.nvim_buf_set_text(0, csrow-1, cscol-1, csrow-1, cscol-1 + #selection, {converted_str})
    else
        -- 複数行の場合、最初と最後の行で特別な処理が必要
        local first_line = vim.api.nvim_buf_get_lines(0, csrow-1, csrow, false)[1]
        local prefix = first_line:sub(1, cscol-1)
        local last_line = vim.api.nvim_buf_get_lines(0, cerow-1, cerow, false)[1]
        local suffix = last_line:sub(cecol+1)
        local converted_lines = vim.split(converted_str, "\n", true)
        converted_lines[1] = prefix .. converted_lines[1]
        converted_lines[#converted_lines] = converted_lines[#converted_lines] .. suffix

        -- 元の選択範囲を削除し、変換後のテキストを挿入
        vim.api.nvim_buf_set_lines(0, csrow-1, cerow, false, converted_lines)
    end
end

vim.api.nvim_create_user_command('SnakeCase', function()
    convert_selection_to_case(to_snake_case)
end, {range = true})

vim.api.nvim_create_user_command('PascalCase', function()
    convert_selection_to_case(to_pascal_case)
end, {range = true})

-- WSL clipboard
if os.getenv("WSL_DISTRO_NAME") ~= nil then
    local clip = 'iconv -t sjis | clip.exe'
    if vim.fn.executable('iconv') == 1 and vim.fn.executable('clip.exe') == 1 then
        local grp = augroup("wsl_yank", { clear = true })
        autocmd("TextYankPost", {
            group = grp,
            pattern = '*',
            callback = function()
                vim.fn.system(clip, vim.fn.getreg('"'))
            end,
        })
    end
end
