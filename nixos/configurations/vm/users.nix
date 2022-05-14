{ pkgs, ... }:

{
  users = {
    mutableUsers = false;

    users.josh = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      password = "";
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
      ../../../home/modules/pass
      ../../../home/modules/nvim
      ../../../home/modules/tmux
    ];

    home.packages = with pkgs; [
      magic-wormhole
    ];
  };
}
