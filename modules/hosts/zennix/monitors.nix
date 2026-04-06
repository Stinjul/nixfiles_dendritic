{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix =
    { config, ... }:
    {
      monitors = [
        {
          name = "DP-2";
          width = 2560;
          height = 1440;
          refreshRate = 165;
          x = 0;
          rotate = 270;
        }
        {
          name = "DP-3";
          width = 2560;
          height = 1440;
          refreshRate = 165;
          x = 1440;
          primary = true;
        }
        {
          name = "HDMI-A-1";
          width = 1920;
          height = 1080;
          refreshRate = 50;
          x = 5000;
        }
      ];
      boot.kernelParams = map (
        m:
        "video=${toString m.name}:${toString m.width}x${toString m.height}@${toString m.refreshRate},rotate=${toString m.rotate}"
      ) (config.monitors);
    };
}
