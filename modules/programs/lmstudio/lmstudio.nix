{
  flake.modules.homeManager.lmstudio =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.lmstudio ];
    };

}
