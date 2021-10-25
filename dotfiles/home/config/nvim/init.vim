" plugins ----------------------------------------------------------------------

" install vim-plug if it is not already installed
if empty(glob('~/.local/share/nvim/plugged'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" some defaults i expect
Plug 'tpope/vim-sensible'

" comment stuff out (e.g. `gc` to comment out higlighted lines)
Plug 'tpope/vim-commentary'

" makes netrw usable
Plug 'tpope/vim-vinegar'

" asychronous building, testing, etc
Plug 'tpope/vim-dispatch'

" navigation between related files, e.g. test and implementation
Plug 'tpope/vim-projectionist'

" do git things in vim
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" lazy-loaded support for a bunch of languages
Plug 'sheerun/vim-polyglot'

" view man pages in vim
Plug 'vim-utils/vim-man'

" visualize vim undo history and switch between branches
Plug 'mbbill/undotree'

" formatting
Plug 'sbdchd/neoformat'

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
Plug 'joshdick/onedark.vim'

" generate and manage ctags
" Plug 'ludovicchabant/vim-gutentags'

" fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" i took some of the above plugins from https://github.com/ThePrimeagen/.dotfiles
" here's more intriguing stuff that i don't feel like looking into right now
"
" " telescope requirements...
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
"
" " lsp Plugins
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'
" " Plug 'nvim-lua/completion-nvim'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'simrat39/symbols-outline.nvim'
" " Plug 'tjdevries/nlua.nvim'
" " Plug 'tjdevries/lsp_extensions.nvim'

" " Neovim Tree shitter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'

" " Debugger Plugins
" Plug 'puremourning/vimspector'
" Plug 'szw/vim-maximizer'

" " should I try another status bar???
" "  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" " Plug 'hoob3rt/lualine.nvim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#end()

" settings, etc. ---------------------------------------------------------------

" use comma as the leader key
let mapleader=' '

" hide abandoned buffers rather than unloading them
set hidden

" show line numbers
set number

" open new vertical splits on the right
set splitright

" pressing tab inserts two spaces
set tabstop=2 shiftwidth=2 expandtab

" enable the mouse
set mouse=a

" <Leader>y yanks to the system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" <Leader>p pastes from the system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" <space> clears highlighting
nnoremap , :nohlsearch<cr>

" enable true color
set termguicolors

" c o l o r s c h e m e
" colorscheme nord
" colorscheme slate
colorscheme onedark

" automatically run `terraform fmt` when saving a terraform file
let g:terraform_fmt_on_save=1

" don't autoindent new lines in markdown
let g:vim_markdown_new_list_item_indent = 0

" coc extensions for completion in various languages
" let g:coc_global_extensions = [
"       \'coc-tsserver',
"       \'coc-json',
"       \'coc-html',
"       \'coc-css',
"       \'coc-git',
"       \'coc-pyright',
"       \'coc-fzf-preview',
"       \'coc-java',
"       \'coc-markdownlint',
"       \'coc-markdown-preview-enhanced',
"       \'coc-rust-analyzer',
"       \'coc-sh',
"       \'coc-solargraph',
"       \'coc-sql',
"       \'coc-toml',
"       \'coc-xml',
"       \'coc-yaml'
"       \]

" <Leader>d opens my dotfiles repo
nnoremap <Leader>d :edit /home/nick/workspace/github.com/nwmahoney/dotfiles<cr>

" <Leader>v opens nvim configuration
nnoremap <Leader>v :edit $MYVIMRC<cr>

" fzf mappings
nnoremap <Leader><space> :FZF<cr>

" reloads vimrc after saving but keeps cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" autopopulate shell script template for `.sh` file extensions
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.rb 0r ~/.vim/templates/skeleton.rb
  augroup END
endif

autocmd BufNewFile,BufRead *.rasi setf css

" pausing this one... vim seems like it doesn't have access to zsh aliases...
" <Leader>m renders markdown and opens it in the browser
" nnoremap <Leader>m :!{render_markdown_and_open_in_firefox %}<cr>
