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
      autoprune = true;
    };
  };

  services.syncoid = {
    enable = true;

    # This doesn't work since the systemd unit restrics FS access.
    # sshKey = "/nix/passwords/backups_ed25519";
    # TODO: put this somewhere in state
    # Also need known_hosts for the synoid user
    sshKey = "/etc/backups_ed25519";

    localSourceAllow = [ "bookmark" "hold" "send" ];

    localTargetAllow = [ "mount" "create" "receive" "keylocation" "mountpoint" ];

    commonArgs = [ "--no-sync-snap" "--no-rollback" ];

    commands."x13/state" = {
      recursive = true;
      sendOptions = "w";
      # TODO: DNS entry for this
      target = "backups@5.161.152.96:coffer/backups/x13";
    };
  };

  programs.ssh.knownHosts = {
    "5.161.152.96".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpeXYsVsDVWcvF7YfXTZTB5w2XGI8ssLAEhhxOJKL0S";
  };
}
