{
  flake.modules.homeManager.element =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        element-desktop
      ];
    };
}
