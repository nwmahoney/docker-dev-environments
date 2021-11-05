set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set mouse=a

set relativenumber
set nu

set hidden

set nowrap

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch

set termguicolors

set scrolloff=8

set completeopt=menuone,noinsert,noselect

set signcolumn=yes
set colorcolumn=80

" Give more space for displaying messages
set cmdheight=2

" Primeagen had this one. Sounds nice but don't really know what
" it does.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
" set updatetime=50

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" install vim-plug if it is not already installed
if empty(glob('~/.local/share/nvim/plugged'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

" LSP (neovim-lsp?)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
" diagnostics?

" treesitter
" undotree
" fugediff tpope



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" copied from my old vimrc
" TODO: clean this up!

" some defaults i expect
" Plug 'tpope/vim-sensible'

" comment stuff out (e.g. `gc` to comment out higlighted lines)
Plug 'tpope/vim-commentary'

" makes netrw usable
Plug 'tpope/vim-vinegar'

" asychronous building, testing, etc
" Plug 'tpope/vim-dispatch'

" navigation between related files, e.g. test and implementation
" Plug 'tpope/vim-projectionist'

" do git things in vim
" Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'

" lazy-loaded support for a bunch of languages
" Plug 'sheerun/vim-polyglot'

" view man pages in vim
" Plug 'vim-utils/vim-man'

" visualize vim undo history and switch between branches
" Plug 'mbbill/undotree'

" formatting
" Plug 'sbdchd/neoformat'

" search for and read RFCs in vim
" needs python3 support. run the following:
" :checkhealth provider
" Plug 'mhinz/vim-rfc'

" quickly switch between colorschemes
" (F8: next, Shift-F8: previous, Alt-F8: random)
" (only seems to work with the default colorschemes)
" Plug 'felixhummel/setcolors.vim'

" a bunch of colorschemes to try
" (onedark is in here but a bit broken)
" Plug 'flazz/vim-colorschemes'
" Plug 'chriskempson/base16-vim'
" Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light
colorscheme solarized8

" let g:onedark_terminal_italics=1
" colorscheme onedark

" let g:gruvbox_italics=1
" colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
--------------------------------------------------------------------------------
-- copied from https://github.com/williamboman/nvim-lsp-installer#setup

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup()
    vim.cmd [[ do User LspAttachBuffers ]]
end)

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- copied from https://github.com/neovim/nvim-lspconfig

local nvim_lsp = require('lspconfig')

-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--   -- Enable completion triggered by <c-x><c-o>
--   -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings.
--   local opts = { noremap=true, silent=true }
--
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--
-- end

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- copied from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'elmls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end
-- require'lspconfig'.elmls.setup {
--     on_attach = on_attach,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     capabilities = capabilities
-- }

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

--------------------------------------------------------------------------------

-- I think I don't need this because of lsp_installer, but not totally sure.
-- require'lspconfig'.elmls.setup{}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " "


" <Leader>y yanks to the system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y gg"+yG

" <Leader>p pastes from the system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" <Leader>d opens my dotfiles repo
nnoremap <Leader>d :edit /home/nick/workspace/github.com/nwmahoney/dotfiles<CR>

" <Leader>v opens my nvim configuration
nnoremap <Leader>c :edit $MYVIMRC<CR>

" <Leader>r reloads my nvim configuration
nnoremap <Leader>v :source ~/.config/nvim/init.vim<CR>

" <Leader>, clears search highlighting
nnoremap <Leader>, :nohlsearch<CR>

nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>h :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>f :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>[ :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <Leader>] :lua vim.lsp.diagnostic.goto_next()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! TrimTrailingWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup NWM
    autocmd!

    " Trim trailing whitespace on save.
    autocmd BufWritePre * :call TrimTrailingWhitespace()

    " Format Elm code on save.
    autocmd BufWritePre *.elm lua vim.lsp.buf.formatting_sync(nil, 1000)

    " Autopopulate templates for new files with matching file extensions.
    " TODO: Can this be improved with "snippets" (whatever those are)?
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.rb 0r ~/.vim/templates/skeleton.rb
augroup END

" TODO
" - check out https://github.com/theprimeagen/.dotfiles
" - check out https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim/
" - break out into separate files
"   - as seen here (22:41): https://www.youtube.com/watch?v=DogKdiRx7ls&t=176s
