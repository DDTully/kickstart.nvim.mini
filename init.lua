local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- keymaps
now(function()
  local map = vim.keymap.set
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  map('n', '<Esc>', '<cmd>nohlsearch<CR>')
  map('n', '<Tab>', '<cmd>bnext<CR>')
  map('n', '<S-Tab>', '<cmd>bprev<CR>')
  map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  map('n', ';', ':', { desc = 'CMD enter command mode' })
  map('i', 'jk', '<ESC>')
  map('n', '<F2>', ':%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>')
  map('n', 'n', 'nzzzv')
  map('n', 'N', 'Nzzzv')
  map('v', 'J', ":m '>+1<CR>gv=gv")
  map('v', 'K', ":m '<-2<CR>gv=gv")
  map({ 'n', 'v' }, '<leader>y', [["+y]])
  map('n', '<leader>Y', [["+Y]])
  map('n', '<C-k>', '<cmd>cnext<CR>zz')
  map('n', '<C-j>', '<cmd>cprev<CR>zz')
  map('n', '<leader>k', '<cmd>lnext<CR>zz')
  map('n', '<leader>j', '<cmd>lprev<CR>zz')
  map({ 'n', 'i', 'v' }, '<C-s>', '<ESC><cmd> w <cr>')
  map({ 'n', 'v' }, '<leader>qq', '<cmd> qa! <cr>')
  map({ 'n', 'v' }, '<C-c>', '<ESC><ESC><ESC>')
  map('n', '<leader>x', '<cmd>lua MiniBufremove.delete()<CR>')
  map('n', '<F5>', vim.cmd.UndotreeToggle)
  map('n', '<F6>', vim.cmd.UndotreeFocus)
  map('n', 'q', '<nop>')
  map('n', '<leader>tw', '<cmd>set wrap!<cr>')
  map('n', '<leader>tn', '<cmd>set relativenumber!<cr>')
  map('n', '<A-m>', '<cmd>MarkdownPreview<cr>')
end)

-- options
now(function()
  local g = vim.g
  local o = vim.opt
  g.have_nerd_font = true
  g.undotree_CustomUndotreeCmd = 'vertical 40 new'
  g.undotree_CustomDiffpanelCmd = 'belowright 12 new'
  o.number = true
  o.relativenumber = true
  o.mouse = 'a'
  o.showmode = false
  o.clipboard = 'unnamed,unnamedplus'
  o.breakindent = true
  o.undofile = true
  o.ignorecase = true
  o.smartcase = true
  o.signcolumn = 'yes'
  o.updatetime = 250
  o.timeoutlen = 300
  o.splitright = true
  o.splitbelow = true
  o.list = true
  o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
  o.inccommand = 'split'
  o.cursorline = true
  o.scrolloff = 10
  o.wrap = false
  o.expandtab = true
  o.shiftwidth = 4
  o.smartindent = true
  o.tabstop = 4
  o.softtabstop = 4
  o.hlsearch = true
  o.spelllang = 'en_us'
  o.spell = true
end)

now(function()
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })
end)

-- which-key
now(function()
  add {
    source = 'folke/which-key.nvim',
    event = 'VimEnter',
  }
  require('which-key').setup()
  require('which-key').register {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  }
end)

-- telescope
now(function()
  add {
    source = 'nvim-telescope/telescope.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  }
  require('telescope').setup {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end)

-- LSP
now(function()
  add {
    source = 'neovim/nvim-lspconfig',
    depends = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
  }
  require('mason').setup()
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    { 'lua_ls', version = '3.8.3' },
    'stylua', -- Used to format Lua code
    'powershell_es',
    'prettier',
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  require('mason-lspconfig').setup()
  require('lspconfig').lua_ls.setup {
    settings = {
      Lua = {
        diagnostics = {
          disable = { 'lowercase-global', 'undefined-global' },
        },
      },
    },
  }
  require('lspconfig').powershell_es.setup {
    filetypes = { 'ps1', 'psm1', 'psd1' },
    bundle_path = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services',
    settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
    init_options = {
      enableProfileLoading = false,
    },
  }
end)

-- conform
now(function()
  add {
    source = 'stevearc/conform.nvim',
  }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
    },
  }
  vim.keymap.set('n', '<leader>f', function()
    require('conform').format { async = true, lsp_fallback = true }
  end, { desc = '[F]ormat buffer' })
end)

-- all the minis
-- one liners
now(function()
  require('mini.ai').setup()
  require('mini.bufremove').setup()
  require('mini.comment').setup()
  require('mini.surround').setup()
  require('mini.tabline').setup()
  require('mini.operators').setup()
  require('mini.pairs').setup()
  require('mini.splitjoin').setup()
end)

-- anything with additional config
now(function()
  require('mini.notify').setup {
    lsp_progress = {
      enable = true,
      duration_last = 200,
    },
  }
  require('mini.statusline').setup {
    use_icons = true,
  }
  require('mini.indentscope').setup {
    draw = {
      animation = function()
        return 1
      end,
    },
    symbol = '│',
  }
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    desc = 'Disable indentscope for certain filetypes',
    callback = function()
      local ignore_filetypes = {
        'aerial',
        'dashboard',
        'help',
        'lazy',
        'leetcode.nvim',
        'mason',
        'neo-tree',
        'NvimTree',
        'neogitstatus',
        'notify',
        'startify',
        'toggleterm',
        'Trouble',
      }
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
        vim.b.miniindentscope_disable = true
      end
    end,
  })
  require('mini.completion').setup {
    window = {
      info = { border = 'rounded' },
      signature = { border = 'rounded' },
    },
  }
end)

-- additional plugins
-- one liners
now(function()
  add { source = 'mbbill/undotree' }
end)

-- anything with additional config
now(function()
  add {
    source = 'folke/tokyonight.nvim',
  }
  vim.cmd.colorscheme 'tokyonight-night'
  vim.cmd.hi 'Comment gui=none'
end)

now(function()
  add { source = 'hedyhli/outline.nvim' }
  require('outline').setup {}
  vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
end)

now(function()
  add { source = 'nvim-tree/nvim-tree.lua' }
  depends = { 'nvim-tree/nvim-web-devicons' }
  local nvimtree = require 'nvim-tree'
  nvimtree.setup {
    view = {
      width = 35,
      relativenumber = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        glyphs = {
          folder = {
            arrow_closed = '', -- arrow when folder is closed
            arrow_open = '', -- arrow when folder is open
          },
        },
      },
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    filters = {
      custom = { '.DS_Store' },
    },
    git = {
      ignore = false,
    },
  }
  vim.keymap.set('n', '<leader>ee', '<cmd>NvimTreeOpen<CR>', { desc = 'Open file explorer' }) -- toggle file explorer
  vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer on current file' }) -- toggle file explorer on current file
  vim.keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
  vim.keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' }) -- refresh file explorer
end)

now(function()
  add { source = 'jakobkhansen/journal.nvim' }
  require('journal').setup {
    filetype = 'md', -- Filetype to use for new journal entries
    root = '~/journal', -- Root directory for journal entries
    date_format = '%d/%m/%Y', -- Date format for `:Journal <date-modifier>`
    autocomplete_date_modifier = 'end', -- "always"|"never"|"end". Enable date modifier autocompletion
    -- Configuration for journal entries
    journal = {
      -- Default configuration for `:Journal <date-modifier>`
      format = '%Y/%m-%B/daily/%Y-%m-%d',
      template = '# %A - %B %d %Y\n',
      frequency = { day = 1 },
    },
  }
end)
now(function()
  add {
    source = 'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
  }
  vim.fn['mkdp#util#install']()
end)
