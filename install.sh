#!/bin/bash
cp .Xresources $HOME/
cp .dwmrc $HOME/
cp .vimrc $HOME/
cp .clang-format $HOME/
cp .ycm_extra_conf.py $HOME/
cp init.lua $HOME/.config/nvim/

#if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
#    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#fi

# Install plugins
if command -v nvim ; then
    nvim -c
    cd ~/.local/share/nvim/lazy/YouCompleteMe/
    ./install.py --all
fi

#if command -v vim ; then
#    # Download vim-plug if not exist
#    if [ ! -f ~/.vim/autoload/plug.vim ]; then
#        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#    fi
#
#    vim +PlugInstall +PlugUpdate +qall
#    cd ~/.vim/plugged/YouCompleteMe/;
#    ./install.py --all
#fi

