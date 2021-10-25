custom docker dev environment

- if glyphs aren't rendering in LunarVim, check out [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
  - needs to be installed on host machine. try running the following commands:

        git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
        cd nerd-fonts
        git sparse-checkout add patched-fonts/DejaVuSansMono
        ./install DejaVuSansMono

  - alternatively, check out [this repo for installing nerd fonts](https://github.com/ronniedroid/getnf)
- if typing `ctrl-p` in the container (e.g. to scroll through command line history) is behaving abnormally, add the following to `$HOME/.docker/config.json` (on the host machine)

        {
          "detachKeys": "ctrl-q,ctrl-q"
        }

  - if this doesn't work, check if `$DOCKER_CONFIG` is set to something other than `$HOME/.docker` (on the host machine)
  - additionally, sudo can change the value of `$HOME` (on the host machine)
    - one option is to add `Defaults	env_keep+="HOME"` to `/etc/sudoers` using `visudo` (on the host machine)
    - see [this stackexchange answer for more info](https://unix.stackexchange.com/a/91572)
