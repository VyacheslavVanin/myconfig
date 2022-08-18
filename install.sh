#!/bin/bash
#cp .Xresources $HOME/
#cp .dwmrc $HOME/
#cp .vimrc $HOME/
#cp .clang-format $HOME/
#cp .ycm_extra_conf.py $HOME/

# Download vim-plug if not exist
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install plugins
if command -v nvim ; then
    nvim +PlugInstall +PlugUpdate +qall
fi

if command -v vim ; then
    vim +PlugInstall +PlugUpdate +qall
fi

cd ~/.vim/plugged/YouCompleteMe/;
./install.py --clangd-completer --go-completer
