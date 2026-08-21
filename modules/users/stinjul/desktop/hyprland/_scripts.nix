{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop =
    { config, pkgs, ... }:
    {
      wayland.windowManager.hyprland.settings =
        let
          spamclick = pkgs.writeShellScript "autoclicker-hold" ''
            PIDFILE="/tmp/holdclick_$1.pid"

            start() {
              if [ -f "$PIDFILE" ]; then
                kill "$(cat "$PIDFILE")" 2>/dev/null
                rm -f "$PIDFILE"
              fi

              (
                while true; do
                  ${pkgs.ydotool}/bin/ydotool click "$1"
                  sleep "$2"
                done
              ) &

              echo $! > "$PIDFILE"
            }

            stop() {
              if [ -f "$PIDFILE" ]; then
                kill "$(cat "$PIDFILE")" 2>/dev/null
                rm -f "$PIDFILE"
              fi
            }

            case "$2" in
              start) start $3 $4 ;;
              stop) stop ;;
            esac
          '';
        in
        {
          bind = [
            "CONTROL, mouse:275, exec, ${spamclick} fastr start 0xC1 0.05"
            "CONTROL + ALT, mouse:275, exec, ${spamclick} superfastr start 0xC1 0.025"
          ];
          bindr = [
            "CONTROL, mouse:275, exec, ${spamclick} fastr stop"
            "CONTROL + ALT, mouse:275, exec, ${spamclick} superfastr stop"
          ];
        };
    };
}
