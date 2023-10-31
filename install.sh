#! /bin/bash

BASE_DIR=$PWD

# sets pacman.conf to improve downloads (parallel downloads and color)
sudo cp ./pacman.conf /etc/pacman.conf

# installs packages, a lot of them
sudo pacman -Syyu --noconfirm --needed git base-devel neovim zsh feh chromium dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi github-cli noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation vlc playerctl pwgen ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
yay -Y --gendb
cd $BASE_DIR

# installs gnome terminal (with transparency) and rofi-greenclip
yay -S --noprovides --answerclean All --answerdiff None --mflags "--noconfirm --needed --clean" rofi-greenclip gnome-terminal-transparency

# installs packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir -p themes videos documents pictures downloads wallpapers .fonts .config

cd ~/.config
rm -rf i3
rm -rf polybar
rm -rf rofi
rm -rf yay
rm -rf nvim
rm -rf dconf
rm -rf gtk-3.0
rm -rf picom

# symlinks configs, wallpapers, configs, fonts and etc
cd $BASE_DIR
ln -sf ./wallpapers/* ~/wallpapers/
ln -sf ./.config/* ~/.config/
ln -sf ./.fonts/* ~/.fonts/
ln -sf ./themes/* ~/themes/

ln -sf ./gitconfig ~/.gitconfig
ln -sf ./zshrc ~/.zshrc

# sets zsh as default
sudo chsh $USER -s $(which zsh)

# for screen brightness control
sudo chmod +s $(which light)

echo ""
echo ""
echo ""
echo "Tudo pronto :)"
read -s -n 1 -p "Aperte qualquer tecla para entrar em seu i3 novinho"

# bye bye :)
sudo systemctl start lightdm.service
