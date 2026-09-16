{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix = {
    networking = {
      useDHCP = true;
      firewall = {
        # 1714 -> 1764: KDEConnect
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPorts = [
          2456 # Valheim gameport
          2457 # Valheim server browser/steam port
        ];
      };
    };
    programs.steam = {
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
