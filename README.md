# Docker Dev Environments

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



### Notes

- Would the problems this is trying to solve be better addressed with custom package
  groups?
  - Problems with this approach:
    - Potentially unnecessary use of space.
      - E.g. the man pages are excluded in the base archlinux docker image.
        Sharing the man pages directory would break encapsulation because man
        pages for packages installed inside the container would be installed
        on the host machine. If they aren't shared then that is a bunch of
        duplicated man pages.
      - Could this be solved with a functional paradigm OS? Could the notion
        of immutability be applied here somehow to share files safely? So they
        could be logically separate but share the underlying resource (e.g. on
        disk). Everything on disk is read or delete only and only gets deleted
        when nothing points to them?
  - Brainstorm:
    - Config file somewhere that has a list of languages that I want to be able to work on.
    - All related packages get installed automatically.
      - I maintain a list of all related packages? That's what I'm doing in this docker approach.
    - All relavant config (e.g. nvim config) gets set up.
      - This would probably work best if my config is broken up into more granular files.
        I'm already doing that. I just need a merging strategy.
