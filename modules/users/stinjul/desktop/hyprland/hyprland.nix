{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop = moduleWithSystem (
    { self', ... }:
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cursor = "Bibata-Modern-Classic-Hyprcursor";
      cursorPackage = self'.packages.bibata-hyprcursor;
    in
    {
      # Yeah, I know, but I need to set the primary monitor for XWayland somehow
      home.packages = with pkgs; [
        xrandr
        grimblast
      ];

      wayland.windowManager.hyprland = {
        sourceFirst = true;

        settings = {
          env = [
            "HYPRCURSOR_THEME,${cursor}"
            "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
          ];
          exec-once = [ "hyprctl setcursor ${cursor} ${toString config.home.pointerCursor.size}" ];

          general = {
            gaps_in = 3;
            gaps_out = 10;
            border_size = 3;
          };
          input = {
            kb_layout = "be,us";
            numlock_by_default = true;
            follow_mouse = 1;
          };
          decoration = {
            rounding = 15;
            blur = {
              enabled = true;
              size = 8;
              passes = 3;
              new_optimizations = true;
              ignore_opacity = true;
            };
          };
        };
      };

      xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
    }
  );
}
