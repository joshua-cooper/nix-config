{ pkgs, ... }:

{
  imports = [
    ../aerc
    ../alacritty
    ../base
    ../bemenu
    ../darkman
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
    brave
    devbox
    imv
    inkscape
    libnotify
    signal-desktop
    start-sway
    vscodium
    wl-clipboard
  ];

  pinentry.gnome.enable = true;
}
