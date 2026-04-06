{

  flake.modules.homeManager.wayland =
    {
      pkgs,
      ...
    }:
    {
      home = {
        packages = with pkgs; [
          wayvnc
        ];
        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
        };
      };
      xdg.portal.enable = true;
    };
}
