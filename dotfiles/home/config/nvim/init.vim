""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins.

" install vim-plug if it is not already installed
if empty(glob('~/.local/share/nvim/plugged'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Telescope.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Colorschemes.
Plug 'lifepillar/vim-solarized8'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'

" LSP. I set this up pretty quickly. It would probably be worth going back
" over this.
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Autocompletion. This is pretty tightly coupled with LSP and I'm not sure I
" have the separation right. E.g. maybe `hrsh7th/cmp-nvim-lsp` goes in the LSP
" section.
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
" TODO: Learn more about Snippets.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Git.
Plug 'tpope/vim-fugitive'
" TODO: Use `lualine` instead? Or `itchyny/lightline.vim`?
" Plug 'vim-airline/vim-airline'
" TODO: Add git indicator to status line. From the README:
"   Add %{FugitiveStatusline()} to 'statusline' to get an indicator with the
"   current branch in your statusline.

" A game for practicing Vim movements.
Plug 'ThePrimeagen/vim-be-good'

" Probably want all three of these.
" treesitter
" undotree
" fugitive



" ------------------------------------------------------------------------------
" copied from my old vimrc
" TODO: clean this up!

" some defaults i expect
" Plug 'tpope/vim-sensible'

" Can I get this functionality through the LSP plugins?
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

" ------------------------------------------------------------------------------



call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps.

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

" <Leader>` toggles between light and dark backgrounds.
function ToggleBackgroundColor()
  if &background ==# "dark"
    !sed -i -- 's/^set background=dark$/set background=light/' ~/.config/nvim/plugin/colorscheme.vim
    set background=light
  else
    !sed -i -- 's/^set background=light$/set background=dark/' ~/.config/nvim/plugin/colorscheme.vim
    set background=dark
  endif
endfun
nnoremap <Leader>` :call ToggleBackgroundColor()<CR>

" <Leader>r reloads my nvim configuration
nnoremap <Leader>v :source ~/.config/nvim/init.vim<CR>:runtime! plugin/**/*.vim<CR>

" <Leader>, clears search highlighting
nnoremap <Leader>, :nohlsearch<CR>

" LSP.
" TODO: Delete this section, but also consider moving other plugin-specific
" maps to the relevant file.
" nnoremap <Leader>d :lua vim.lsp.buf.definition()<CR>
" nnoremap <Leader>h :lua vim.lsp.buf.hover()<CR>
" nnoremap <Leader>r :lua vim.lsp.buf.rename()<CR>
" nnoremap <Leader>f :lua vim.lsp.buf.formatting()<CR>
" nnoremap <Leader>[ :lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <Leader>] :lua vim.lsp.diagnostic.goto_next()<CR>

" Telescope.
nnoremap <Leader><Space> :lua require("telescope.builtin").find_files({ hidden = true })<CR>
nnoremap <Leader>/ :lua require("telescope.builtin").live_grep()<CR>
" This next one came from that Primeagen video. `Project Search`. The tradeoff
" compared to the above `live_grep` is that the grep doesn't live update as
" you type the pattern, but you get to fuzzy find on the filenames containing
" the pattern.
nnoremap <Leader>f :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>
nnoremap <Leader>* :lua require('telescope.builtin').grep_string()<CR>
nnoremap <Leader>e :lua require('telescope.builtin').file_browser({ hidden = true })<CR>
" TODO: Install `nvim-treesitter`. See `:help builtin.treesitter()`.
nnoremap <Leader>tt :lua require('telescope.builtin').treesitter()<CR>
" TODO: Checkout other Telescope Git Builtins. Documentation should be easy to
" find near `:help builtin.git_status`.
nnoremap <Leader>gs :lua require('telescope.builtin').git_status()<CR>
nnoremap <Leader>tc :lua require('telescope.builtin').commands()<CR>
nnoremap <Leader>th :lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>tm :lua require('telescope.builtin').man_pages()<CR>
nnoremap <Leader>tb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>t` :lua require('telescope.builtin').colorscheme()<CR>
nnoremap <Leader>tk :lua require('telescope.builtin').keymaps()<CR>
" TODO: Figure this one out. I like the idea of being able to fuzzy find my
" command history but this needs some polishing.
" cnoremap <C-p> :lua require('telescope.builtin').command_history()<CR>
" TODO: Test this one and uncomment once we understand quickfix lists better.
" nnoremap <Leader>tq :lua require('telescope.builtin').quickfix()<CR>
" TODO: The following builtin pickers didn't seem to be worth mapping now but seemed
" intriguing. See `:help builtin.<picker>()`
" - `marks`
" - `registers`
" - `filetypes`
" - `highlights`
" - `tagstack`/`jumplist`
" - `lsp_references`
"   - Honestly, all of the `lsp_*` builtin pickers seem like they could be
"     super useful.

" Git (`vim-fugitive`).
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gd :Gvdiffsplit<CR>
nnoremap <Leader>gh :diffget //2<CR>
nnoremap <Leader>gl :diffget //3<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands.

fun! TrimTrailingWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup NWM
    autocmd!

    " Trim trailing whitespace on save.
    autocmd BufWritePre * :call TrimTrailingWhitespace()

    " Format Elm Code on save.
    autocmd BufWritePre *.elm lua vim.lsp.buf.formatting_sync(nil, 1000)

    " Format Javascript code on save.
    autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)

    " Autopopulate templates for new files with matching file extensions.
    " TODO: Can this be improved with `snippets` (whatever those are)?
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.rb 0r ~/.vim/templates/skeleton.rb

    " Open `:help` in a vertical split.
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO
"
" - check out https://github.com/theprimeagen/.dotfiles
" - check out https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim/
" - check out https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
" - break out into separate files
"   - as seen here (22:41): https://www.youtube.com/watch?v=DogKdiRx7ls&t=176s
" - current movements, commands, etc that I want to get better at using
"   - f, t, F, T, ';', ','
"   - s (delete character and enter insert mode - kinda like 'r')
"   - S (delete line and enter insert mode - kinda like 'C')
"   - '{', '}' (jump to next/previous empty line
"   - '%' (jump to matching pair, e.g. '(' -> ')'
"   - mixing <num> with 'i' (change/delete/etc within layers of nested things
"     - e.g. d2i{ (delete everything inside the curly braces one level up)
"   - things like 'cip' (change in paragraph)
"   - 'a' as alternative to 'i' (includes the matching thing, e.g. '(')
"   - telescope for opening a different filegit@github.com:nwmahoney/.dotfiles.git
"   - `ctrl-6` to jump between two files
"   - `ctrl-]` to follow links and lookup words in `:help`
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
