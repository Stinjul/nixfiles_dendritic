{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.user-stinjul-desktop = {
  };
  flake.modules.homeManager.user-stinjul-desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    in
    {
      imports = with inputs.self.modules.homeManager; [
        pywal
      ];
      fontProfiles = {
        enable = true;
        monospace = {
          family = "IosevkaTerm Nerd Font Mono";
          package = pkgs.nerd-fonts.iosevka-term;
        };
        regular = {
          family = "Iosevka";
          package = pkgs.iosevka;
        };
      };
      home = {
        file.".local/share/themes/${theme.name}" = {
          source = "${theme.package}/share/themes/${theme.name}";
        };
      };
      gtk = {
        inherit theme;
        font = {
          name = config.fontProfiles.regular.family;
          size = 11;
        };
      };
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
}
