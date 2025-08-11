--local vim_config_path = vim.fn.expand('~/.vimrc')
--local vim_config_exists = vim.fn.filereadable(vim_config_path) == 1
--
---- Load existing Vim configuration if desired
--if vim_config_exists and vim.g.load_vimrc ~= false then
--  vim.cmd('source ' .. vim_config_path)
--  print("Loaded existing .vimrc for compatibility")
--end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {'Valloric/YouCompleteMe'},
    {'flazz/vim-colorschemes'},
    {'jaxbot/semantic-highlight.vim'},
    {'luochen1990/rainbow'},
    {'vim-scripts/DoxygenToolkit.vim'},
    {'tpope/vim-fugitive'},
    {'airblade/vim-gitgutter'},
    {'ctrlpvim/ctrlp.vim'},
    {'vim-scripts/The-NERD-tree'},
    {'vim-scripts/surround.vim'},
    {'bling/vim-airline'},
    {'vim-airline/vim-airline-themes'},
    {'easymotion/vim-easymotion'},
    {'kris2k/a.vim'},
    {'alfredodeza/khuno.vim'},
    {'vim-syntastic/syntastic'},
    {"VyacheslavVanin/llm-requester.nvim", branch = "tools", submodules = true},

    {'rhysd/libclang-vim'},

    {'nvim-lua/plenary.nvim'},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require('llm-requester').setup({
  chat = {
      api_type = 'ollama',
      --api_type = 'openai',
      --openai_url = 'https://openrouter.ai/api/v1',
      --openai_model = 'qwen2.5-coder:latest',
      --openai_api_key = '<YOUR API KEY>', --openrouter key

      ollama_url = 'http://localhost:11434',
      ollama_model = 'qwen3-coder:latest',

      stream = true,
      split_ratio = 0.5,
      prompt_split_ratio = 0.1,
      prompt = '', -- automaticaly add to you prompt
      context_size = 16384,
      temperature = 0.5,
      top_k = 20,
      top_p = 0.95,
      max_rps = 1,
      no_verify_ssl = false, -- set true only if you know what you are doing
      server_port = 8000, -- local server to hold chat sessions and tools
  },
  completion = {
      api_type = 'ollama',
      --api_type = 'openai',
      --openai_url = 'https://openrouter.ai/api/v1',
      --openai_model = 'qwen2.5-coder:latest',
      --openai_api_key = '<YOUR API KEY>', --openrouter key

      ollama_url = 'http://localhost:11434',
      ollama_model = 'qwen3-coder:latest',

      context_lines = 500,
      context_size = 16384,

      keys = {
          trigger = '<S-Tab>',
          confirm = '<Tab>',
      },
      temperature = 0.1,
  },
})

-- Set global options
vim.o.encoding = 'utf-8'
vim.o.errorbells = false
vim.o.visualbell = false
vim.cmd('colorscheme solarized8_dark')

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = false
vim.o.colorcolumn = '80'
vim.o.textwidth = 80

vim.o.autoindent = true
vim.o.cindent = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.ruler = true
vim.o.syntax = 'on'
vim.o.backspace = 'indent,eol,start'
vim.o.mouse = 'a'

vim.o.scrolloff = 5

if vim.fn.has("gui_running") == 1 then
    vim.o.guifont = 'DejaVu\\ Sans\\ Mono\\ 16'
    vim.o.go = '!M'
end

vim.o.background = 'dark'
vim.o.laststatus = 2
vim.o.cursorline = true
vim.g.rainbow_active = 0
vim.g.ycm_confirm_extra_conf = 0
vim.g.ycm_autoclose_preview_window_after_completeon = 1
vim.g.ycm_autoclose_preview_window_after_insertion = 1

vim.g.DoxygenToolkit_compactOneLineDoc = "yes"
vim.g.DoxygenToolkit_compactDoc = "yes"

vim.g.NERDTreeWinPos = "right"
-- vim.g.NERDTreeIgnore = {'\.vim$', '\~$', '.o$[[file]]'}
-- vim.g.NERDTreeIgnore = {'\~$', '.o$[[file]]'}

-- ctrlp filter
vim.opt.wildignore:append({'*/tmp/*', '*.so', '*.swp', '*.zip', '*.tar.gz', '*.o', '*.png', '*.jpg'})
vim.g.ctrlp_custom_ignore = '\\v[\\/]\\.(git|hg|svn)$'


-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<M-f>', ':vimgrep /<C-r>// **/*.cpp **/*.[ch] **/*.hpp <CR> :copen<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-e><M-w>', ':e ++enc=cp1251<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-e><M-u>', ':e ++enc=utf-8<CR>', { noremap = true, silent = false })

-- Visual mode mappings
vim.api.nvim_set_keymap('v', '<M-f>', ':vimgrep /<C-r>"/ **/*.cpp **/*.[ch] **/*.hpp <CR> :copen<CR>', { noremap = true, silent = false })

-- Function mappings
vim.api.nvim_set_keymap('n', '<F12>', ':YcmCompleter GoToDefinitionElseDeclaration<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', ':YcmDiags<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F3>', '%!clang-format<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F11>', ':YcmCompleter FixIt<CR>', { noremap = true, silent = false })

-- DoxygenToolKit mappings
vim.api.nvim_set_keymap('i', '/**', '<Esc> :Dox<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-d>', ':Dox<CR>', { noremap = true, silent = false })

-- Switch source/header
vim.api.nvim_set_keymap('n', '<F4>', ':A<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-o>', ':NERDTreeToggle<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<C-w>t', ':tabnew<CR>', { noremap = true, silent = false })

-- Toggle rainbow colors
vim.api.nvim_set_keymap('n', '<F6>', ':SemanticHighlightToggle<CR>:RainbowToggle<CR>', { noremap = true, silent = false })

-- Ru mapping
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- Tab mappings
vim.api.nvim_set_keymap('n', '<M-1>', '1gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-2>', '2gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-3>', '3gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-4>', '4gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-5>', '5gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-6>', '6gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-7>', '7gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-8>', '8gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-9>', '9gt', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-0>', '10gt', { noremap = true, silent = false })

-- Selection to table
vim.api.nvim_set_keymap('v', '<M-t>', ':!column -t \\| sed -e "s/\\s\\+$//g"<CR>', { noremap = true, silent = false })
