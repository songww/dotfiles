brew install antigen alacritty aria2 \
    bat bazel \
    cmake \
    dust \
    eslint exa \
    fd ffmpeg flamegraph fzf \
    git gitlint git-interactive-rebase-tool git-lfs \
    htop \
    jq jsonlint \
    llvm \
    make mycli mysql-client \
    node \
    openjdk \
    p7zip procs python \
    reattach-to-user-namespace ripgrep \
    sd \
    tealdeer tmux tree-sitter \
    urlview vim wget \
    xh xz zoxide

brew install homebrew/cask-fonts/font-cascadia-code \
             homebrew/cask-fonts/font-cascadia-code-pl \
             homebrew/cask-fonts/font-cascadia-mono \
             homebrew/cask-fonts/font-cascadia-mono-pl

ln -sf `pwd`/tmux.conf $HOME/.tmux.conf

ln -sf `pwd`/alacritty.yml $HOME/.config/alacritty/alacritty.yml

git clone https://github.com/tmux-plugins/tpm \
    $HOME/.tmux/plugins/tpm

# install plugins
bash $HOME/.tmux/plugins/tpm/bin/install_plugins
