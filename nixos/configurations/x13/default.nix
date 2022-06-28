{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    ./boot.nix
    ./hardware.nix
    ./power-management.nix
    ./file-systems.nix
    ./networking.nix
    ./users.nix
    ../../modules/environment
    ../../modules/iwd
    ../../modules/systemd-resolved
    ../../modules/nix
    ../../modules/openssh
    ../../modules/fish
    ../../modules/sway
    ../../modules/pipewire
    ../../modules/xdg-desktop-portal
    ../../modules/home-manager
  ];

  system.stateVersion = "22.05";
}
