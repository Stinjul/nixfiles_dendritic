{
  flake.modules.nixos.yubikey-touch-detector =
    {
      config,
      lib,
      ...
    }:
    {
      programs.yubikey-touch-detector = {
        enable = true;
      };
    };
}
