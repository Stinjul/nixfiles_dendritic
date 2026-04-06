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
      imports = with inputs.self.modules.homeManager; [
        kitty
      ];
      xdg.configFile."kitty/scratchpad.session" = {
        source = ./scratchpad.session;
      };
    };
}
