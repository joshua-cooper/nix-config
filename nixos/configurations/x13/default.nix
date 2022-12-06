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
      target = "root@zh2641b.rsync.net:data1/x13";
    };
  };

}
