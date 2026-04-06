{
  flake.modules.homeManager.fonts =
    { lib, config, ... }:
    let
      mkFontOption = kind: {
        family = lib.mkOption {
          type = lib.types.str;
          default = null;
          description = "Family name for ${kind} font profile";
          example = "Fira Code";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = null;
          description = "Package for ${kind} font profile";
          example = "pkgs.fira-code";
        };
      };
      cfg = config.fontProfiles;
    in
    {
      options.fontProfiles = {
        enable = lib.mkEnableOption "Whether to enable font profiles";
        monospace = mkFontOption "monospace";
        regular = mkFontOption "regular";
      };

      config = lib.mkIf cfg.enable {
        fonts.fontconfig.enable = true;
        home.packages = [
          cfg.monospace.package
          cfg.regular.package
        ];
        gtk = lib.mkIf config.gtk.enable {
          font = {
            name = lib.mkDefault config.fontProfiles.regular.family;
          };
        };
        programs = {
          kitty = {
            font.name = config.fontProfiles.monospace.family;
          };
        };
      };
    };
}
