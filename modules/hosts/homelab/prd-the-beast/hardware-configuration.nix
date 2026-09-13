{
  inputs,
  ...
}:
{
  flake.modules.nixos.prd-the-beast = {
    boot = {
      initrd = {
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usb_storage"
          "sr_mod"
        ];
      };
      kernelModules = [
        "kvm-amd"
      ];
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
