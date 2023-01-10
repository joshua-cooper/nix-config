{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    inputs.impermanence.nixosModule
    inputs.nur.nixosModules.nur
    ../../profiles/systemd-boot
    ../../profiles/workstation
    ../../profiles/zfs
    ./boot.nix
    ./file-systems.nix
    ./hardware.nix
    ./networking.nix
    ./power-management.nix
    ./state.nix
    ./users.nix
  ];

  system.stateVersion = "22.05";

  time.timeZone = "Asia/Seoul";

  services.sanoid = {
    enable = true;

    datasets."x13/state" = {
      autosnap = true;
      autoprune = false;
    };
  };

  services.zfs-backup = {
    enable = true;
  };

  programs.ssh.knownHosts = {
    "x13".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFzrWwVWBZPpVP809744I0hpUncoDJ9goUBTt6JcY2AD";
    "zh2641b.rsync.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKlIcNwmx7id/XdYKZzVX2KtZQ4PAsEa9KVQ9N43L3PX";
  };
}
