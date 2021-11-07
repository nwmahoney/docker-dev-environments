FROM archlinux:latest
LABEL authors="Nick Mahoney <nick.mahoney00@gmail.com>"

################################################################################
# root user

# install packages (and upgrade existing packages)
RUN pacman --noconfirm -Syu \
      base-devel \
      man-db \
      man-pages \
      pkgfile \
      neovim \
      zsh \
      zsh-completions \
      git \
      tree \
      xclip \
      ripgrep \
      fasd \
      fd \
      nodejs \
      yarn \
      npm \
      python \
      python-pip \
      ruby \
      rust \
      openssh \
      bat \
      git-delta \
      firefox \
      stow

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
COPY --chown=nick dotfiles/home/oh-my-zsh/custom/themes/pygmalion.zsh-theme \
       /home/nick/.oh-my-zsh/custom/themes/pygmalion.zsh-theme
COPY --chown=nick dotfiles/home/zsh_aliases \
       /home/nick/.zsh_aliases
COPY --chown=nick dotfiles/home/zshrc \
       /home/nick/.zshrc
COPY --chown=nick dotfiles/home/zshenv \
       /home/nick/.zshenv

# setup neovim
# old dotfiles
RUN mkdir -p /home/nick/.config/nvim
COPY --chown=nick dotfiles/home/config/nvim/init.vim \
       /home/nick/.config/nvim/init.vim
RUN mkdir -p /home/nick/.vim/templates
COPY --chown=nick dotfiles/home/vim/templates/skeleton.sh \
       /home/nick/.vim/templates/skeleton.sh
# new dotfiles
COPY --chown=nick .dotfiles /home/nick/.dotfiles
RUN cd ~/.dotfiles && stow nvim
RUN nvim --headless +'PlugInstall --sync' +qa

# setup git
COPY --chown=nick dotfiles/home/gitconfig \
       /home/nick/.gitconfig

CMD ["zsh"]
