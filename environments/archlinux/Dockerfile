FROM archlinux:latest
LABEL authors="Nick Mahoney <nick.mahoney00@gmail.com>"

# Use a default build dir so we don't accidentally leave any artifacts in `/`.
WORKDIR /build

# Start with a reasonable mirrorlist for Humboldt County.
COPY mirrorlist /etc/pacman.d/mirrorlist

# Update the system, and install packages needed to install `yay` and
# `rate-mirrors`. We'll install any other required packages after we have
# updated the mirrorlist.
RUN pacman --noconfirm -Syyu git base-devel pacman-contrib

# Create build user with passwordless sudo privileges so we can run commands
# that refuse to be run as root.
RUN useradd builduser -m && \
    passwd -d builduser && \
    printf 'builduser ALL=(ALL) ALL\n' >> /etc/sudoers

# Install `yay` (`makepkg` refuses to run as `root`).
RUN sudo -u builduser bash -c \
      "cd ~ && \
      git clone https://aur.archlinux.org/yay.git && \
      cd yay && \
      makepkg --noconfirm -sri"

# Update mirrorlist and update the system using the new mirrorlist.
# (copied from https://github.com/westandskif/rate-mirrors)
RUN sudo -u builduser bash -c \
      'yay --noconfirm -S rate-mirrors && \
      export TMPFILE="$(mktemp)" && \
      rate-mirrors --save=$TMPFILE arch --max-delay=21600 && \
      sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup && \
      sudo mv $TMPFILE /etc/pacman.d/mirrorlist && \
      paccache -rk3 && \
      yay --noconfirm -Sc --aur && \
      yay --noconfirm -Syyu'
