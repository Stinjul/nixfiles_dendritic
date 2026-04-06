{

  flake.modules.homeManager.kitty =
    { lib, ... }:
    {
      home = {
        sessionVariables = {
          TERMINAL = "kitty -1";
        };
      };
      programs.kitty = {
        enable = true;
        font = {
          size = lib.mkDefault 11;
        };
        settings = {
          window_padding = lib.mkDefault 10;
          background_opacity = lib.mkDefault "0.8";
        };
      };
    };
}
