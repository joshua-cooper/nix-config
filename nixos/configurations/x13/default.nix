{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    inputs.impermanence.nixosModule
    inputs.nur.nixosModules.nur
    ./boot.nix
    ./hardware.nix
    ./power-management.nix
    ./file-systems.nix
    ./networking.nix
    ./users.nix
    ./state.nix
    ../../modules/environment
    ../../modules/iwd
    ../../modules/systemd-resolved
    ../../modules/nix
    ../../modules/openssh
    ../../modules/docker
    ../../modules/fish
    ../../modules/sway
    ../../modules/pipewire
    ../../modules/xdg-desktop-portal
    ../../modules/home-manager
  ];

  system.stateVersion = "22.05";

  security = {
    sudo.enable = false;
    doas.enable = true;
  };
}
