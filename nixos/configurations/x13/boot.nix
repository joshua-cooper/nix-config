{ pkgs, ... }:

{
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
}
