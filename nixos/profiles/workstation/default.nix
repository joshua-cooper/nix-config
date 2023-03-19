{ config, pkgs, ... }:

{
  imports = [
    ../base
    ../doas
    ../docker
    ../fish
    ../home-manager
    ../nix
    ../pipewire
    ../plymouth
    ../ssh
    ../sway
    ../systemd-boot
    ../systemd-networkd
    ../systemd-resolved
    ../xdg-desktop-portal
    ../zfs
  ];

  networking.nameservers = [ "1.1.1.1#one.one.one.one" ];

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
      ../../../home/profiles/workstation
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
