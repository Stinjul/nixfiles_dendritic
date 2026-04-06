{
  inputs,
  config,
  ...
}:
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    # https://nix-community.github.io/home-manager/options.xhtml#opt-xdg.portal.enable
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
    home-manager = {
      # verbose = true;
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
      backupCommand = "rm";
      overwriteBackup = true;
    };
  };
}
