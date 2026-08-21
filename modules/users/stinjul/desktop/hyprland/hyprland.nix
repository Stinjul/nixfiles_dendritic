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

      wayland.windowManager.hyprland =
        let
          lua = lib.generators.mkLuaInline;
          env = name: value: {
            _args = [
              name
              value
            ];
          };
          startupEvent = cmd: {
            _args = [
              "hyprland.start"
              (lua ''function() hl.dsp.exec_cmd("${cmd}") end'')
            ];
          };
        in
        {
          sourceFirst = true;
          configType = "lua";

          settings = {
            env = [
              (env "HYPRCURSOR_THEME" cursor)
              (env "HYPRCURSOR_size" (toString config.home.pointerCursor.size))
            ];
            on = [
              (startupEvent "hyprctl setcursor ${cursor} ${toString config.home.pointerCursor.size}")
            ];

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

      xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
    }
  );
}
