{

  flake.modules.homeManager.mpv =
    { lib, ... }:
    {
      programs.mpv = {
        enable = true;
        config = {
          profile = lib.mkDefault "gpu-hq";
        };
      };
    };
}
