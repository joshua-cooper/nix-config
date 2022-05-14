{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];

      luks.devices.vault.device = "/dev/disk/by-uuid/c88e6ba4-95e9-47f3-b2cf-c3e3d0d4b569";
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [ "kvm-intel" ];

    kernelParams = [ "i915.enable_psr=0" ];
  };
}
