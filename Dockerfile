FROM archlinux:latest
LABEL authors="Nick Mahoney <nick.mahoney00@gmail.com>"

################################################################################
# root user

# install packages (and upgrade existing packages)
RUN pacman --noconfirm -Syu \
      which \
      sudo \
      man-db \
      man-pages \
      texinfo \
      pkgfile \
      neovim \
      zsh \
      zsh-completions \
      git \
      tree \
      ripgrep \
      fasd \
      bat

# sync the pkgfile database
RUN pkgfile --update

# setup the nick user with no password and sudo access
RUN useradd \
      --create-home \
      --groups wheel \
      --shell /bin/zsh \
      nick && \
    passwd -d nick && \
    echo '%wheel ALL=(ALL) ALL' | tee -a /etc/sudoers
################################################################################
# nick user

USER nick
WORKDIR /home/nick

# setup zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mkdir -p /home/nick/.oh-my-zsh/custom/themes
COPY dotfiles/home/oh-my-zsh/custom/themes/pygmalion.zsh-theme \
       /home/nick/.oh-my-zsh/custom/themes/pygmalion.zsh-theme
COPY dotfiles/home/zsh_aliases \
       /home/nick/.zsh_aliases
COPY dotfiles/home/zshrc \
       /home/nick/.zshrc

# setup neovim
RUN mkdir -p /home/nick/.config/nvim
COPY dotfiles/home/config/nvim/init.vim \
       /home/nick/.config/nvim/init.vim
RUN mkdir -p /home/nick/.vim/templates
COPY dotfiles/home/vim/templates/skeleton.sh \
       /home/nick/.vim/templates/skeleton.sh
RUN nvim --headless +'PlugInstall --sync' +qa

CMD ["zsh"]
