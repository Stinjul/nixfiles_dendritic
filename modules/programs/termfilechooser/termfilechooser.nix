{
  flake.modules.homeManager.termfilechooser =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.xdg.portal.termfilechooser;
      settingsFormat = pkgs.formats.ini { };
      configFile = settingsFormat.generate "xdg-desktop-portal-termfilechooser.ini" cfg.settings;
    in
    {
      options.xdg.portal.termfilechooser = {
        enable = lib.mkEnableOption { };
        package = lib.mkPackageOption pkgs "xdg-desktop-portal-termfilechooser" { };
        settings = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.submodule {
              freeformType = settingsFormat.type;
            }
          );
          default = null;
        };
      };
      config = lib.mkIf cfg.enable {
        xdg.portal = {
          enable = true;
          extraPortals = [ cfg.package ];
          config.common."org.freedesktop.impl.portal.FileChooser" = [ "xdg-desktop-portal-termfilechooser" ];
        };

        xdg.configFile."systemd/user/xdg-desktop-portal-termfilechooser.service.d/overrides.conf".text =
          lib.mkIf (cfg.settings != null)
            ''
              [Service]
              ExecStart=
              ExecStart=${cfg.package}/libexec/xdg-desktop-portal-termfilechooser --config=${configFile}
            '';
      };
    };
}
