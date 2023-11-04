sudo pacman -S --needed --noconfirm unzip
curl -fsSL https://bun.sh/install | bash

export PATH=$PATH:~/.bun/bin

cd i3-install
bun install
cd ..
bun $(pwd)/i3-install/index.ts

