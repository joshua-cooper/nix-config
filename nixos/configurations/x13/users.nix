{ pkgs, ... }:

{
  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "i2c" "docker" ];
    shell = pkgs.fish;
  };

  home-manager.users.josh = {
    imports = [
      ../../../home/modules/xdg-dirs
      ../../../home/modules/direnv
      ../../../home/modules/fish
      ../../../home/modules/git
      ../../../home/modules/gpg
      ../../../home/modules/gpg-agent
      ../../../home/modules/pass
      ../../../home/modules/nvim
      ../../../home/modules/htop
      ../../../home/modules/tmux
      ../../../home/modules/playerctl
      ../../../home/modules/sway
      ../../../home/modules/swaylock
      ../../../home/modules/swayidle
      ../../../home/modules/kanshi
      ../../../home/modules/mako
      ../../../home/modules/alacritty
      ../../../home/modules/mpv
    ];

    home.packages = with pkgs; [
      wl-clipboard
      libnotify
    ];
  };
}
