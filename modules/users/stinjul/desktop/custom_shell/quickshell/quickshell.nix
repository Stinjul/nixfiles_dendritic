{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-custom =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        quickshell
      ];
      programs.quickshell = {
        configs = {
          main = ./config;
        };
        activeConfig = "main";
      };
    };
}
