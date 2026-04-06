{
  flake.modules.homeManager.vintagestory =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.vintagestory ];
    };

}
