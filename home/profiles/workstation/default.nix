{ pkgs, ... }:

{
  imports = [
    ../aerc
    ../alacritty
    ../base
    ../bemenu
    ../direnv
    ../email
    ../firefox
    ../fish
    ../fonts
    ../git
    ../gpg
    ../gpg-agent
    ../gtk
    ../htop
    ../kanshi
    ../mako
    ../mpd
    ../mpv
    ../ncmpcpp
    ../neovim
    ../pass
    ../pass-menu
    ../playerctl
    ../pointer-cursor
    ../qutebrowser
    ../shell-aliases
    ../sustas
    ../sway
    ../swayidle
    ../swaylock
    ../tmux
    ../xdg-dirs
    ../zathura
  ];

  home.packages = with pkgs; [
    devbox
    imv
    libnotify
    signal-desktop
    vscodium
    wl-clipboard
  ];
}
