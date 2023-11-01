#! /bin/bash

BASE_DIR=$PWD

# sets pacman.conf to improve downloads (parallel downloads and color)
sudo cp ./pacman.conf /etc/pacman.conf

# installs packages, a lot of them
sudo pacman -Syyu --noconfirm --needed git base-devel tldr wget neovim vim zsh feh dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation playerctl pwgen ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip terminator

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm --clean
cd $BASE_DIR

# replaced with terminator
# installing gnome-terminal-transparency
# git clone https://aur.archlinux.org/gnome-terminal-transparency.git
# cd gnome-terminal-transparency
# makepkg -si --noconfirm --clean
# cd $BASE_DIR

# installing zscroll-git
git clone https://aur.archlinux.org/zscroll-git.git
cd zscroll-git
makepkg -si --noconfirm --clean
cd $BASE_DIR

# installing greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/bin

# installs packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir -p videos documents pictures downloads .config

# deletes conflicting directories
cd ~/.config
rm -rf yay

# sets zsh as default
sudo chsh $USER -s $(which zsh)

# symlinks configs, wallpapers, configs, fonts and etc
cd $BASE_DIR
ln -s $(pwd)/.config/* $(pwd)/.config/.* ~/.config
ln -s $(pwd)/home/* $(pwd)/home/.* ~/

# for screen brightness control
sudo chmod +s $(which light)

echo ""
echo ""
echo ""
echo "Tudo pronto :)"
read -s -n 1 -p "Aperte qualquer tecla para entrar em seu i3 novinho"

# bye bye :)
sudo systemctl start lightdm.service
