# Neovim Termux (Sauna Config)

Config Neovim satu-file (`init.lua`) yang dirancang khusus untuk Termux di Android. Ringan, cepat, tapi fiturnya setara dengan IDE modern. Sangat ramah untuk layar sentuh dan keyboard virtual.

## Fitur Utama

- **Dashboard**: Tampilan awal ASCII keren dengan menu cepat.
- **Bufferline**: Tab antar-file di layar atas (bisa ditap dengan jari). Tutup file pakai tombol `x`.
- **File Explorer**: Neo-tree dengan ikon. Panggil lewat tombol `☰` di pojok kiri atas, cukup tap folder/file untuk membuka.
- **Anti Mentok Keyboard**: Baris yang kamu edit selalu di tengah layar (`scrolloff=15`).
- **Word Wrap**: Teks panjang otomatis turun ke bawah, nggak perlu geser layar ke kanan.
- **Autocomplete & LSP**: Autocomplete pintar pas ngetik (LSP, snippets, buffer).
- **Auto-format**: File otomatis rapi pas disimpan (Prettier, Black, Stylua).
- **Fuzzy Finder**: Cari file dan teks super cepat pakai Telescope.
- **Terminal Melayang**: Buka terminal tanpa keluar editor (`Ctrl-\`).
- **Full Touch Support**: Scroll dan pindah kursor pakai jari (`mouse="a"`).

---

## ⚡ Instalasi Cepat (1 Baris)

Buka Termux, copy-paste perintah ini lalu tekan Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/rmt26/Nvim-termux/main/install.sh | bash
```
> **Penting**: Ganti `USERNAME` dan `REPO` di atas dengan milikmu.

---

## Instalasi Manual

1. Install paket yang dibutuhkan:
```bash
pkg install -y neovim git nodejs ripgrep fd clang python termux-api
```
2. Buat folder dan unduh config:
```bash
mkdir -p ~/.config/nvim
curl -fsSL https://raw.githubusercontent.com/rmt26/Nvim-termux/main/init.lua -o ~/.config/nvim/init.lua
```
3. Buka `nvim` dan biarkan plugin terunduh otomatis.
4. Restart nvim.

---

## Font Agar Ikon Muncul

Agar ikon folder dan UI tidak jadi kotak-kotak, pasang **Nerd Font** di Termux:

```bash
curl -fLo ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
termux-reload-settings
```

## Shortcut Penting (Leader = Spasi)

- `Spasi w` : Simpan file
- `Spasi q` : Keluar
- `Spasi e` atau tap `☰` : Buka File Explorer
- `Spasi ff` : Cari file
- `Shift-L` / `Shift-H` : Geser tab file
- `gcc` : Komentari baris

*Lupa shortcut? Tahan tombol Spasi sebentar di mode Normal, menu Which-Key akan muncul.*
