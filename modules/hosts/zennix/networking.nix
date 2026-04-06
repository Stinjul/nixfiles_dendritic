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
          37008 # Wireshark TZSP
        ];
      };
    };
    programs.steam = {
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
