{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    inputs.microvm.nixosModules.host
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

  services.sanoid = {
    enable = true;

    datasets."x13/state" = {
      autosnap = true;
      autoprune = false;
    };
  };

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

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.bridges = {
    br0 = {
      interfaces = [
        # "enp0s31f6"
        "vm-test"
      ];
    };
  };

  networking.interfaces.br0.ipv4.addresses = [{
    address = "192.168.100.1";
    prefixLength = 24;
  }];

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["br0"];
  networking.nat.externalInterface = "wlan0";

  microvm.vms = {
    vm-test = {
      config = {
        microvm.hypervisor = "firecracker";

        microvm.interfaces = [{
          type = "tap";
          id = "vm-test";
          mac = "02:00:00:00:00:01";
        }];

        networking.interfaces.eth0.ipv4.addresses = [{
          address = "192.168.100.2";
          prefixLength = 24;
        }];

        networking.defaultGateway = "192.168.100.1";

        users.users.josh = {
          isNormalUser = true;
          password = "password";
          extraGroups = [ "wheel" ];
        };

        services.openssh.enable = true;

        environment.systemPackages = with pkgs; [
          lf
        ];
      };
    };
  };
}
