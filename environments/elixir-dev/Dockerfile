FROM nmahoney/dev:latest
LABEL authors="Nick Mahoney <nick.mahoney00@gmail.com>"

# install packages (and upgrade existing packages)
RUN sudo pacman --noconfirm -Syu \
      erlang \
      elixir

USER nick
WORKDIR /home/nick

# Setup Elixir LSP.
RUN mkdir -p /home/nick/.local/lib/manually-installed/elixir-ls
WORKDIR /home/nick/.local/lib/manually-installed/elixir-ls
RUN curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
RUN unzip elixir-ls.zip
RUN chmod +x /home/nick/.local/lib/manually-installed/elixir-ls/language_server.sh
RUN ln -sf /home/nick/.local/lib/manually-installed/elixir-ls/language_server.sh /home/nick/.local/bin/elixir-ls
WORKDIR /home/nick

# Add Elixir LSP neovim config.
# TODO: Let's do this better. Maybe add this as it's own file in
# `.../nvim/plugin`. Or switch to actual Lua files and just append this instead
# of using `sed`. Although Lua and seperate file would probably be the
# cleanest.
RUN sed -i 's/^EOF$/nvim_lsp.elixirls.setup{\n  cmd = { "\/home\/nick\/.local\/bin\/elixir-ls" };\n  on_attach = on_attach,\n  capabilities = capabilities,\n}\n\nEOF/' \
      /home/nick/.config/nvim/plugin/lsp.vim

CMD ["zsh"]
