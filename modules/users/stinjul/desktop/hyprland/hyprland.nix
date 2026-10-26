{
  flake.modules.homeManager.user-stinjul-desktop =
    {
      pkgs,
      ...
    }:
    {
      # Yeah, I know, but I need to set the primary monitor for XWayland somehow
      home.packages = with pkgs; [
        xrandr
        grimblast
      ];

      wayland.windowManager.hyprland = {
        sourceFirst = true;
        configType = "lua";

        settings = {
          config = {
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
      };
    };
}
