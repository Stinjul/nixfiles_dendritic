{ inputs, ... }:
{
  flake.modules.nixos.prd-ms01-3 = {
    imports = with inputs.self.modules.nixos; [
      profile-hardware-prd-ms01
    ];

    services.k3s.serverAddr = "https://prd.k3s.stinjul.com:6443";
    networking.hostName = "prd-ms01-3";
  };
}
