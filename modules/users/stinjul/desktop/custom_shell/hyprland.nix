{
  moduleWithSystem,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop-custom = moduleWithSystem (
    { self', ... }:
    {
      lib,
      config,
      ...
    }:
    let
      cursor = "Bibata-Modern-Classic-Hyprcursor";
    in
    {
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
          settings = {
            env = [
              (env "HYPRCURSOR_THEME" cursor)
              (env "HYPRCURSOR_size" (toString config.home.pointerCursor.size))
            ];
            on = [
              (startupEvent "hyprctl setcursor ${cursor} ${toString config.home.pointerCursor.size}")
            ];
          };
        };
    }
  );
}
