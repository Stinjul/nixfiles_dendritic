{
  flake.modules.nixos.fish = {
    programs.fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };
  flake.modules.homeManager.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        plugins = [
          {
            name = "bass";
            src = pkgs.fishPlugins.bass;
          }
        ];
      };
    };
}
