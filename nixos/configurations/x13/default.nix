{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    ../../profiles/laptop
    ../../profiles/mosh
    ../../profiles/silent-boot
    ../../profiles/sshd
    ../../profiles/gitolite
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-intel" "ext4" ];

    kernelParams = [ "i915.enable_psr=0" ];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "mode=755" "size=16G" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

    "/nix" = {
      device = "x13/nix";
      fsType = "zfs";
    };

    "/state" = {
      device = "x13/state";
      fsType = "zfs";
      neededForBoot = true;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    i2c.enable = true;
  };

  networking = {
    hostName = "x13";
    hostId = "c69bb763";
  };

  environment.persistence."/state" = {
    users.josh = {
      directories = [
        "repositories"
        "documents"
        "downloads"
        "music"
        "pictures"
        "videos"
        { directory = ".local/share/gnupg"; mode = "0700"; }
        { directory = ".local/share/password-store"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".config/Signal"; mode = "0700"; }
        { directory = ".config/VSCodium"; mode = "0700"; }
      ];
      files = [ ];
    };
  };

  system.stateVersion = "22.05";

  services.logind.lidSwitchExternalPower = "lock";

  services.sanoid = {
    enable = true;

    datasets."x13/state" = {
      autosnap = true;
      autoprune = false;
    };
  };

  services.dbus.packages = [ pkgs.gcr ];

  services.fwupd.enable = true;

  state.enable = true;

  virtualisation.podman.enable = true;

  services.restic.backups = {
    backblaze = {
      initialize = true;
      passwordFile = "/nix/passwords/restic-password";
      environmentFile = "/nix/passwords/restic.env";
      repository = "s3:s3.us-west-000.backblazeb2.com/backups-x13-844c8c7a";
      paths = [
        "/state"
      ];
      exclude = [
        "target/"
        "node_modules/"
        ".direnv/"
      ];
    };
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.3" ];
    privateKeyFile = "/nix/passwords/wg0";
    peers = [{
      publicKey = "JndZzFFBkn30BTWQo2jJbLitX4gRSZhWFbF8Mf5egRo=";
      allowedIPs = [ "10.100.0.1" ];
      endpoint = "ide.cooper.dev:51820";
    }];
  };
}
