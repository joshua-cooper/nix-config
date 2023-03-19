{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModule
    inputs.nur.nixosModules.nur
    ../../modules
  ];

  boot.initrd.systemd.enable = true;

  environment = {
    defaultPackages = with pkgs; [ neovim gitMinimal ];
    variables.EDITOR = "nvim";
  };

  security.sudo.enable = lib.mkDefault false;

  state = {
    directories = [
      "/var/lib/nixos"
    ];

    files = [
      "/etc/machine-id"
      "/var/lib/systemd/timesync/clock"
    ];
  };
}
