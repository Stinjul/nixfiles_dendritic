{
  moduleWithSystem,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    let
      cursor = "Bibata-Modern-Classic-Hyprcursor";
      cursorPackage = self'.packages.bibata-hyprcursor;
    in
    {
      home = {
        pointerCursor = {
          enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
    }
  );
}
