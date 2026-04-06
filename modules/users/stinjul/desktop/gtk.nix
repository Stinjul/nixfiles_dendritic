{
  inputs,
  self,
  ...
}:
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
    {
      imports = with inputs.self.modules.homeManager; [
        gtk
      ];
      home = {
        pointerCursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      gtk = {
        font = {
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
}
