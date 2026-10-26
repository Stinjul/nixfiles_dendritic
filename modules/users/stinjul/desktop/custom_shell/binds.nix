{
  flake.modules.homeManager.user-stinjul-desktop-custom =
    { lib, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        bind =
          let
            lua = lib.generators.mkLuaInline;
            bind = key: func: {
              _args = [
                key
                (lua func)
              ];
            };
            chord = keys: builtins.concatStringsSep " + " keys;
            exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
            menu = "rofi";

            mainMod = "SUPER";
          in
          [
            (bind (chord [
              mainMod
              "D"
            ]) (exec "${menu} -show run"))
            (bind (chord [
              mainMod
              "TAB"
            ]) (exec "${menu} -show window"))
          ];
      };
    };
}
