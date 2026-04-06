{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        profile-desktop
        bluetooth
        pipewire
        libvirtd
        tuigreet
        mullvad
        podman
        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.nixos-hardware.nixosModules.common-pc-ssd
      ];

      networking.hostName = "zennix";
      system.stateVersion = "23.11";

      console.keyMap = "azerty";

      programs = {
        partition-manager.enable = true;
        nix-ld.enable = true;
        wireshark = {
          enable = true;
          package = pkgs.wireshark;
        };
      };

      services = {
        pcscd = {
          enable = true;
          plugins = [ pkgs.libacr38u ];
        };
        gvfs.enable = true;
        blueman.enable = true;
      };

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        binfmt.emulatedSystems = [ "aarch64-linux" ];
      };
    };
}
