#!/usr/bin/env bash

set -eu -o pipefail

function main {
  local docker_dev_path="$HOME/workspace/github.com/nwmahoney/docker-dev-environments"
  local docker_dev_nvim_plugins_dir="$docker_dev_path/.dotfiles/nvim/.config/nvim/plugin"
  local main_nvim_config_dir="$HOME/.config/nvim"
  local main_nvim_plugins_dir="$main_nvim_config_dir/plugin"
  nvim -c 'silent call TabMultiDiff()' \
    "$main_nvim_config_dir/init.vim" "$docker_dev_path/dotfiles/home/config/nvim/init.vim" \
    "$main_nvim_plugins_dir/autocompletion.vim" "$docker_dev_nvim_plugins_dir/autocompletion.vim" \
    "$main_nvim_plugins_dir/colorscheme.vim" "$docker_dev_nvim_plugins_dir/colorscheme.vim" \
    "$main_nvim_plugins_dir/lsp.vim" "$docker_dev_nvim_plugins_dir/lsp.vim" \
    "$main_nvim_plugins_dir/options.vim" "$docker_dev_nvim_plugins_dir/options.vim" \
    "$main_nvim_plugins_dir/telescope.vim" "$docker_dev_nvim_plugins_dir/telescope.vim" \
    ~/.zshrc "$docker_dev_path/dotfiles/home/zshrc" \
    ~/.zsh_aliases "$docker_dev_path/dotfiles/home/zsh_aliases" \
    ~/.zshenv "$docker_dev_path/dotfiles/home/zshenv" \
    ~/.gitconfig "$docker_dev_path/dotfiles/home/gitconfig" \
    ~/.oh-my-zsh/custom/themes/pygmalion.zsh-theme "$docker_dev_path/dotfiles/home/oh-my-zsh/custom/themes/pygmalion.zsh-theme" \
    ~/.vim/templates/skeleton.sh "$docker_dev_path/dotfiles/home/vim/templates/skeleton.sh"
}

main "$@"

