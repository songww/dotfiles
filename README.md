# My dotfiles

## neovim

Required neovim 0.7+ and node

```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim
ln -s `pwd`/nvim/lua/custom ~/.config/nvim/lua/custom
ln -s `pwd`/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
nvim -c "PackerSync | q"
```
