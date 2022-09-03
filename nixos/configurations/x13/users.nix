{ pkgs, ... }:

{
  users = {
    mutableUsers = false;

    users.josh = {
      isNormalUser = true;
      passwordFile = "/nix/passwords/josh";
      extraGroups = [ "wheel" "i2c" "docker" ];
      shell = pkgs.fish;
    };
  };

  home-manager.users.josh = {
    imports = [
      ../../../home-manager/profiles/workstation
    ];

    home.stateVersion = "22.05";
  };
}
