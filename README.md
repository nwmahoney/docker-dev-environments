custom docker dev environment

- if glyphs aren't rendering in LunarVim, check out [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
  - needs to be installed on host machine. try running the following commands:

        git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
        cd nerd-fonts
        git sparse-checkout add patched-fonts/DejaVuSansMono
        ./install DejaVuSansMono

  - alternatively, check out [this repo for installing nerd fonts](https://github.com/ronniedroid/getnf)
