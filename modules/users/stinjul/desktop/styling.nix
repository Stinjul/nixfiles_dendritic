{ inputs, ... }:
{
  flake.modules.nixos.user-stinjul-desktop = {
    imports = with inputs.self.modules.nixos; [
      gtk
    ];
  };
  flake.modules.homeManager.user-stinjul-desktop =
    {
      pkgs,
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
        gtk
        qt
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
        gtk4.theme = config.gtk.theme;
        font = {
          name = config.fontProfiles.regular.family;
          size = 11;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
}
