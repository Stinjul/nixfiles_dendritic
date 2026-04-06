{
  flake.modules.nixos.profile-hardware-prd-ms01 =
    { pkgs, lib, ... }:
    {
      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
        };
        kernelModules = [
          "kvm-intel"
          "dm-snapshot"
          "drivetemp"
        ];
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernel.sysctl = {
          "net.ipv4.ip_forward" = 1;
          "net.ipv6.conf.all.forwarding" = 1;
          # These need to be increased for k8s
          # Although the default settings might not cause issues initially, you'll get strange behavior after a while
          "fs.inotify.max_user_instances" = 1048576;
          "fs.inotify.max_user_watches" = 1048576;
        };
      };

      nixpkgs.hostPlatform = "x86_64-linux";
    };
}
