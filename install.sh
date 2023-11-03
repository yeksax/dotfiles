sudo pacman -S --needed unzip
curl -fsSL https://bun.sh/install | bash
alias bun=~/.bun/bin/bun

cd i3-install
bun install
cd ..
bun $(pwd)/i3-install/index.ts
