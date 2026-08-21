{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop =
    { config, lib, ... }:
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
            focuswindow = dir: ''hl.dsp.focus({ direction = "${dir}" })'';
            movewindow = dir: ''hl.dsp.window.move({ direction = "${dir}" })'';
            movewindowworkspace = ws: ''hl.dsp.window.move({ workspace = "${ws}" })'';
            focusworkspace = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
            moveworkspace = dir: ''hl.dsp.workspace.move({ monitor = "${dir}" })'';

            terminal = config.home.sessionVariables.TERMINAL;
            menu = "rofi";

            mainMod = "SUPER";
          in
          [
            (bind (chord [
              mainMod
              "RETURN"
            ]) (exec terminal))
            (bind (chord [
              mainMod
              "SHIFT"
              "RETURN"
            ]) ''hl.dsp.workspace.toggle_special("scratchpad")'')

            (bind (chord [
              mainMod
              "SHIFT"
              "Q"
            ]) "hl.dsp.window.close()")
            (bind (chord [
              mainMod
              "F"
            ]) ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
            (bind (chord [
              mainMod
              "SHIFT"
              "SPACE"
            ]) "hl.dsp.window.float()")

            (bind (chord [
              mainMod
              "D"
            ]) (exec "${menu} -show run"))
            (bind (chord [
              mainMod
              "TAB"
            ]) (exec "${menu} -show window"))

            (bind (chord [
              mainMod
              "SHIFT"
              "E"
            ]) "hl.dsp.exit()") # Maybe hyprshutdown?

            (bind (chord [
              mainMod
              "N"
            ]) (exec "dunstctl close"))
            (bind (chord [
              mainMod
              "SHIFT"
              "N"
            ]) (exec "dunstctl close-all"))
            (bind (chord [
              "CONTROL"
              "TAB"
            ]) (exec "dunstctl context"))
            (bind (chord [
              "CONTROL"
              "SHIFT"
              "TAB"
            ]) (exec "dunstctl history-pop"))

            (bind (chord [
              mainMod
              "SHIFT"
              "S"
            ]) (exec "grimblast copy active"))
            (bind (chord [
              mainMod
              "CONTROL"
              "S"
            ]) (exec "grimblast copy area"))

            # "${mainMod}, KP_Add, exec, ~/scripts/rofi/playerctl_selector.sh -c 'volume 0.05+'"
            # "${mainMod}, XF86AudioRaiseVolume , exec, ~/scripts/rofi/playerctl_selector.sh -c 'volume 0.05+'"

            # "${mainMod}, KP_Subtract, exec, ~/scripts/rofi/playerctl_selector.sh -c 'volume 0.05-'"
            # "${mainMod}, XF86AudioLowerVolume , exec, ~/scripts/rofi/playerctl_selector.sh -c 'volume 0.05-'"

            # "${mainMod}, KP_Divide, exec, ~/scripts/rofi/playerctl_selector.sh -r"
            # "${mainMod}, KP_Multiply, exec, ~/scripts/rofi/playerctl_selector.sh"

            # ",XF86AudioPlay, exec, mpc play"
            # ",XF86AudioPause, exec, mpc pause"
            # ",XF86AudioStop, exec, mpc stop"
            # ",XF86AudioNext, exec, mpc next"
            # ",XF86AudioPrev, exec, mpc prev"

          ]
          ++
            lib.concatMap
              (
                { dir, keys }:
                lib.concatMap (key: [
                  (bind (chord [
                    mainMod
                    key
                  ]) (focuswindow dir))
                  (bind (chord [
                    mainMod
                    "SHIFT"
                    key
                  ]) (movewindow dir))
                  (bind (chord [
                    mainMod
                    "CONTROL"
                    key
                  ]) (moveworkspace dir))
                ]) keys
              )
              [
                {
                  dir = "l";
                  keys = [
                    "LEFT"
                    "H"
                  ];
                }
                {
                  dir = "d";
                  keys = [
                    "DOWN"
                    "J"
                  ];
                }
                {
                  dir = "u";
                  keys = [
                    "UP"
                    "K"
                  ];
                }
                {
                  dir = "r";
                  keys = [
                    "RIGHT"
                    "L"
                  ];
                }
              ]
          ++
            lib.concatMap
              ({ key, workspace }: [
                (bind (chord [
                  mainMod
                  key
                ]) (focusworkspace (toString workspace)))
                (bind (chord [
                  mainMod
                  "SHIFT"
                  key
                ]) (movewindowworkspace (toString workspace)))
              ])
              [
                {
                  key = "ampersand";
                  workspace = 1;
                }
                {
                  key = "eacute";
                  workspace = 2;
                }
                {
                  key = "quotedbl";
                  workspace = 3;
                }
                {
                  key = "apostrophe";
                  workspace = 4;
                }
                {
                  key = "parenleft";
                  workspace = 5;
                }
                {
                  key = "section";
                  workspace = 6;
                }
                {
                  key = "egrave";
                  workspace = 7;
                }
                {
                  key = "exclam";
                  workspace = 8;
                }
                {
                  key = "ccedilla";
                  workspace = 9;
                }
                {
                  key = "agrave";
                  workspace = 10;
                }
              ];
      };
    };
}
