{
  flake.modules.homeManager.gale =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gale ];
    };
}
