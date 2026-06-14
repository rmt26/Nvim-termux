#!/bin/bash
echo -e "\033[1;34m==> Memulai instalasi Neovim Sauna untuk Termux...\033[0m"

echo "-> Mengupdate Termux dan memasang dependensi (git, nodejs, python, dll)..."
pkg update -y && pkg upgrade -y
pkg install -y neovim git nodejs ripgrep fd clang python termux-api curl

echo "-> Memasang formatter LSP global..."
npm install -g prettier bash-language-server pyright 2>/dev/null
pip install black 2>/dev/null

echo "-> Membackup config lama (jika ada)..."
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

echo "-> Menyiapkan folder konfigurasi..."
mkdir -p ~/.config/nvim

echo "-> Mengunduh init.lua..."
curl -fsSL https://raw.githubusercontent.com/rmt26/Nvim-termux/main/init.lua -o ~/.config/nvim/init.lua

echo -e "\033[1;32m==> Instalasi Selesai! 🎉\033[0m"
echo "Silakan ketik 'nvim' untuk memulai. Biarkan plugin terunduh otomatis."
