# **`shub39's` Hyprland Dotfiles**

My config files for hyprland and other utilities with some shell scripts that I have been daily driving for about 7 months now. **Heavily customised for my workflow and only meant to be a reference**

> ![](https://ziadoua.github.io/m3-Markdown-Badges/badges/Arch/arch1.svg)
> ![](https://ziadoua.github.io/m3-Markdown-Badges/badges/CSS/css1.svg)
> ![](https://ziadoua.github.io/m3-Markdown-Badges/badges/Linux/linux2.svg)
> ![](https://ziadoua.github.io/m3-Markdown-Badges/badges/Shell/shell3.svg)
> ![](https://ziadoua.github.io/m3-Markdown-Badges/badges/Neovim/neovim1.svg)
> [<img src="https://m3-markdown-badges.vercel.app/stars/1/1/shub39/dotfiles">]()

## Screenshots
![1](screenshots/1.png)
![2](screenshots/2.png)
![3](screenshots/3.png)
![4](screenshots/4.png)

## Packages

### Official Repo
Needed
```
ttf-jetbrains-mono ttf-jetbrains-mono-nerd hyprpicker hyprpaper neovim hyprpolkitagent nwg-look noto-fonts noto-fonts-emoji noto-fonts-extra swaync waybar hyprlock gnome-terminal chromium cava scrcpy nemo rofi-wayland cmus copyq flatpak fastfetch imagemagick
```

My preferred extras
```
mpv loupe gnome-boxes gnome-disk-utility gnome-system-monitor nemo-fileroller
```

### AUR
```
gruvbox-dark-icons-gtk gruvbox-material-gtk-theme-git hyprshot wlogout zen-browser-bin
```

### Flatpak
```
it.mijorus.smile
```

## Installation

- Clone this repo at `.config/` in your home directory

```bash
git clone https://github.com/shub39/dotfiles
```

- Edit `~/.config/hypr/hyprland.conf` to only include `source = ~/.config/dotfiles/hyprland/hyprland.conf`
```bash
echo 'source = ~/.config/dotfiles/hyprland/hyprland.conf' > ~/.config/hypr/hyprland.conf
```

- Reboot

## Extras

- [NvChad](https://nvchad.com/) a preconfigured neovim setup
- [Zsh config](https://github.com/pixegami/terminal-profile) for this setup, **edit the scripts according to your package manager first**

## Star History

[![Stargazers over time](https://starchart.cc/shub39/dotfiles.svg?background=%23282828&axis=%23f2dfd3&line=%23ffb780)](https://starchart.cc/shub39/dotfiles)
