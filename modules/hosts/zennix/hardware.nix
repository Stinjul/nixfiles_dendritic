{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix = {
    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "sr_mod"
        ];
        kernelModules = [ "dm-snapshot" ];
      };
      kernelModules = [
        "kvm-amd"
        "it87"
      ];
      extraModulePackages = [ ];
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
