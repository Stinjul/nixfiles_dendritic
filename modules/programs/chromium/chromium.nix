{
  flake.modules.homeManager.chromium =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        chromium
      ];
    };
}
