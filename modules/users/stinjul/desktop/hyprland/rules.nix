{
  inputs,
  ...
}:
{
  flake.modules.homeManager.user-stinjul-desktop =
    { config, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        window_rule = [
          {
            match = {
              float = false;
              workspace = "f[1]s[false]";
            };
            border_size = 0;
            rounding = 0;
          }
          {
            match.class = "firefox";
            workspace = 4;
          }
          {
            match.class = "^steam_app_.*";
            workspace = 7;
          }
          {
            match.title = ".*(i?)wine.*";
            workspace = 7;
          }
          {
            match.class = "^[Ss]team$";
            workspace = "8 silent";
          }
          {
            match.class = "^[Vv]esktop$";
            workspace = "9 silent";
          }
          {
            match.class = "^[Dd]iscord$";
            workspace = "9 silent";
          }
        ];
        workspace_rule = [
          {
            workspace = "w[tv1]s[false]";
            gaps_out = 0;
            gaps_in = 0;
          }
          {
            workspace = "f[1]s[false]";
            gaps_out = 0;
            gaps_in = 0;
          }
          {
            workspace = "special:scratchpad";
            gaps_out = 20;
            on_created_empty = "${config.home.sessionVariables.TERMINAL} --class dropdown --session ~/.config/kitty/scratchpad.session --instance-group scratchpad --override background_opacity=1";
          }
        ];
      };
    };
}
