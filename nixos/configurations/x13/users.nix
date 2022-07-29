{ pkgs, ... }:

{
  users = {
    mutableUsers = false;

    users = {
      root = {
        passwordFile = "/nix/passwords/root";
      };

      josh = {
        isNormalUser = true;
        passwordFile = "/nix/passwords/josh";
        extraGroups = [ "wheel" "i2c" "docker" ];
        shell = pkgs.fish;
      };
    };
  };

  home-manager.users.josh = {
    imports = [
      ../../../home/modules/xdg-dirs
      ../../../home/modules/direnv
      ../../../home/modules/fish
      ../../../home/modules/git
      ../../../home/modules/gpg
      ../../../home/modules/gpg-agent
      ../../../home/modules/pinentry
      ../../../home/modules/pass
      ../../../home/modules/nvim
      ../../../home/modules/htop
      ../../../home/modules/tmux
      ../../../home/modules/playerctl
      ../../../home/modules/pointer-cursor
      ../../../home/modules/gtk
      ../../../home/modules/sway
      ../../../home/modules/swaylock
      ../../../home/modules/swayidle
      ../../../home/modules/kanshi
      ../../../home/modules/mako
      ../../../home/modules/bemenu
      ../../../home/modules/alacritty
      ../../../home/modules/mpv
      ../../../home/modules/zathura
      ../../../home/modules/firefox
      ../../../home/modules/themes
    ];

    home = {
      stateVersion = "22.05";

      packages = with pkgs; [
        wl-clipboard
        libnotify
        imv
      ];
    };
  };
}
