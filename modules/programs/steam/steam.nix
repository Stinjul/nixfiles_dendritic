{ inputs, ... }:
{
  flake.modules.nixos.steam =
    { pkgs, lib, ... }:
    {
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.steam
      ];
      boot.kernelModules = [ "ntsync" ];
      programs = {
        steam = {
          enable = true;
          protontricks.enable = true;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
          gamescopeSession.enable = true;
        };
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = true;
        };
      };
    };
  flake.modules.homeManager.steam =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        yafc-ce
        mangohud
      ];
    };
}
