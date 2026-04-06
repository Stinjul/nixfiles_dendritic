{
  flake.modules.nixos.locale =
    { lib, ... }:
    {
      time.timeZone = lib.mkDefault "Europe/Brussels";
    };
}
