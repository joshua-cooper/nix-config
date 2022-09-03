{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    inputs.impermanence.nixosModule
    inputs.nur.nixosModules.nur
    ../../profiles/workstation
    ./boot.nix
    ./file-systems.nix
    ./hardware.nix
    ./networking.nix
    ./power-management.nix
    ./state.nix
    ./users.nix
  ];

  system.stateVersion = "22.05";

  security = {
    sudo.enable = false;
    doas.enable = true;
  };
}
