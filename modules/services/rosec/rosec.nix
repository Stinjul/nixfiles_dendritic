{
  flake.modules.nixos.rosec = {
    services.rosec = {
      enable = true;
      pam.enable = true;
    };
  };

  flake.modules.homeManager.rosec =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.rosec;
      format = pkgs.formats.toml { };
    in
    {
      options.services.rosec = {
        enable = lib.mkEnableOption { };
        package = lib.mkPackageOption pkgs "rosec" { };
        settings = lib.mkOption {
          type = format.type;
          default = { };
        };
      };

      config = lib.mkIf cfg.enable {
        home.packages = [ cfg.package ];

        xdg.portal = {
          config.common."org.freedesktop.impl.portal.Secret" = [ "rosec" ];
          extraPortals = [ cfg.package ];
        };
        dbus.packages = [ cfg.package ];

        xdg.configFile = lib.mkIf (cfg.settings != { }) {
          "rosec/config.toml".source = format.generate "config.toml" cfg.settings;
        };
      };
    };
}
