{
  flake.modules.nixos.zennix =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
      users.users.stinjul.extraGroups = [ "wireshark" ];
      networking.firewall.allowedUDPPorts = [
        37008 # Wireshark TZSP
      ];
    };
}
