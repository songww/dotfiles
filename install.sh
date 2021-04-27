brew install antigen alacritty aria2 \
    bat bazel bottom \
    cmake \
    dust \
    eslint exa \
    fd ffmpeg flamegraph fzf \
    git gitlint git-interactive-rebase-tool git-lfs \
    htop \
    jq jsonlint \
    llvm \
    make mycli mysql-client \
    note \
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

ln -s tmux.conf $HOME/.tmux.conf

ln -s alacritty.yml $HOME/.config/alacritty/alacritty.yml
