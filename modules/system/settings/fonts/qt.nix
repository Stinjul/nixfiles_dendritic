{
  inputs,
  ...
}:
{
  flake.modules.homeManager.fonts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      qtctBaseConf = {
        Appearance = {
          custom_palette = true;
          icon_theme = lib.mkDefault config.gtk.iconTheme.name;
          standard_dialogs = lib.mkDefault "xdgdesktopportal";
          style = lib.mkDefault "Fusion";
        };
        Interface = {
          activate_item_on_single_click = 1;
          buttonbox_layout = 0;
          cursor_flash_time = 1000;
          dialog_buttons_have_icons = 1;
          double_click_interval = 400;
          gui_effects = "@Invalid()";
          keyboard_scheme = 2;
          menus_have_icons = true;
          show_shortcuts_in_context_menus = true;
          stylesheets = "@Invalid()";
          toolbutton_style = 4;
          underline_shortcut = 1;
          wheel_scroll_lines = 3;
        };
      };

      generalFont = inputs.self.lib.mkQfontString {
        family = config.fontProfiles.regular.family;
        pointSize = 12;
        styleName = "Regular";
      };
      fixedFont = inputs.self.lib.mkQfontString {
        family = config.fontProfiles.monospace.family;
        pointSize = 12;
        styleName = "Regular";
      };

      qt5ctConf = lib.recursiveUpdate qtctBaseConf {
        Appearance = {
          color_scheme_path = "${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf";
        };
        Fonts = {
          general = ''"${generalFont.qt5String}"'';
          fixed = ''"${fixedFont.qt5String}"'';
        };
      };
      qt6ctConf = lib.recursiveUpdate qtctBaseConf {
        Appearance = {
          color_scheme_path = "${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf";
        };
        Fonts = {
          general = ''"${generalFont.qt6String}"'';
          fixed = ''"${fixedFont.qt6String}"'';
        };
      };

      cfg = config.fontProfiles;
    in
    {
      config = lib.mkIf cfg.enable {
        qt = {
          qt5ctSettings = qt5ctConf;
          qt6ctSettings = qt6ctConf;
        };
        # xdg.configFile = {
        #   "qt5ct/qt5ct.conf".text = lib.mkDefault lib.generators.toINI { } qt5ctConf;
        #   "qt6ct/qt6ct.conf".text = lib.mkDefault lib.generators.toINI { } qt6ctConf;
        # };
      };
    };
}
