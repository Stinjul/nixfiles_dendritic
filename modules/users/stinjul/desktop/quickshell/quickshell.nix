{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.quickshell = {
        configs = {
          main = ./config;
        };
        activeConfig = "main";
      };
    };
}
