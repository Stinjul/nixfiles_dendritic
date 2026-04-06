{
  inputs,
  ...
}:
{
  flake.modules.nixos.profile-hardware-prd-ms01 =
    {
      config,
      lib,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        profile-cli
        k3s-cluster
        "${inputs.nixos-hardware}/common/cpu/intel/alder-lake"
      ];

      sops.secrets.k3s-token-prd.sopsFile = ./secrets.sops.yaml;

      networking = {
        useDHCP = false;
        firewall = {
          enable = false;
        };
      };

      systemd.network = {
        enable = true;
        networks = {
          "20-lan" = {
            matchConfig.Name = "enp87s0";
            networkConfig = {
              DHCP = "ipv4";
            };
            linkConfig.RequiredForOnline = "routable";
          };
        };
      };

      environment.persistence."/k3s" = {
        directories = [
          "/var/lib/rancher/k3s/server/db"
        ];
      };
      services.k3s = {
        tokenFile = config.sops.secrets.k3s-token-prd.path;
        extraFlags = [
          "--tls-san prd.k3s.stinjul.com"
        ];
        registries = {
          mirrors = {
            "docker.io".endpoint = [ "https://docker-registry.mgmt.stinjul.com" ];
            "registry.k8s.io".endpoint = [ "https://k8s-registry.mgmt.stinjul.com" ];
            "ghcr.io".endpoint = [ "https://github-registry.mgmt.stinjul.com" ];
            "quay.io".endpoint = [ "https://quay-registry.mgmt.stinjul.com" ];
            "xpkg.upbound.io".endpoint = [ "https://upbound-registry.mgmt.stinjul.com" ];
          };
        };
      };

      console.keyMap = "azerty";

      system.stateVersion = "25.05";
    };
}
