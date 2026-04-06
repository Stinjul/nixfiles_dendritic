{ inputs, ... }:
{
  flake.modules.nixos.prd-ms01-1 = {
    imports = with inputs.self.modules.nixos; [
      profile-hardware-prd-ms01
    ];

    services.k3s.clusterInit = true;
    networking.hostName = "prd-ms01-1";
  };
}
