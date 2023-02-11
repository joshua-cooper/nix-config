{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    ../../profiles/laptop
    ../../profiles/mosh
    ../../profiles/sshd
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
    video.hidpi.enable = true;
    i2c.enable = true;
  };

  networking = {
    hostName = "x13";
    hostId = "c69bb763";
    nameservers = [ "1.1.1.1#one.one.one.one" ];
    useNetworkd = true;
  };

  systemd.network.wait-online.anyInterface = true;

  environment.persistence."/state" = {
    directories = [
      "/var/log"
    ];

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

  state.enable = true;

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

  virtualisation.podman.enable = true;
}
