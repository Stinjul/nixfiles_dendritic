{
  inputs,
  self,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-dux =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkIf;
    in
    {
      programs.kitty.extraConfig = mkIf config.programs.kitty.enable ''
        include dank-tabs.conf
        include dank-theme.conf
      '';
      wayland.windowManager.hyprland.extraConfig = mkIf config.wayland.windowManager.hyprland.enable ''
        require("dms/colors")
        require("dms/cursor")
      '';
      gtk = {
        gtk3.extraCss = ''@import url("dank-colors.css");'';
        gtk4.extraCss = ''@import url("dank-colors.css");'';
      };
      qt = {
        qt5ctSettings.Appearance.color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/matugen.conf";
        qt6ctSettings.Appearance.color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/matugen.conf";
      };
    };
}
