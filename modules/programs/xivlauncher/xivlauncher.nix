{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.xivlauncher = moduleWithSystem (
    { self', ... }:
    { ... }:
    {
      home.packages = [ self'.packages.xivlauncher-gamemode ];
    }
  );

}
