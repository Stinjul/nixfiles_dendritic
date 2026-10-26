{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-custom =
    {
      config,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        termfilechooser
      ];
      xdg.portal.termfilechooser = {
        enable = true;
        settings = {
          filechooser = {
            cmd = "${config.xdg.portal.termfilechooser.package}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
            env = "TERMCMD=${config.home.sessionVariables.TERMINAL}";
            default_dir = "$HOME";
          };
        };
      };
    };
}
