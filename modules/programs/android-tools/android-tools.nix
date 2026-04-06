{
  flake.modules.homeManager.android-tools =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.android-tools ];
    };
}
