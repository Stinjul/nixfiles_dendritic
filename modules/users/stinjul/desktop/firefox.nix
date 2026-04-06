{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop = {
    imports = with inputs.self.modules.homeManager; [
      firefox
    ];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
  };
}
