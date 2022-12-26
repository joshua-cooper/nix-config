{ pkgs, ... }:

{
  imports = [
    ../../modules/pinentry
    ../../modules/themes
    ../aerc
    ../alacritty
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
    ../playerctl
    ../pointer-cursor
    ../qutebrowser
    ../sustas
    ../sway
    ../swayidle
    ../swaylock
    ../tmux
    ../xdg-dirs
    ../zathura
  ];

  home.packages = with pkgs; [
    imv
    libnotify
    signal-desktop
    wl-clipboard
  ];
}
