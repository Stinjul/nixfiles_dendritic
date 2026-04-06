{
  flake.modules.nixos.firmware = {
    nixpkgs.config.allowUnfree = true;

    services.fwupd.enable = true;
    hardware = {
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
    };
  };
}
