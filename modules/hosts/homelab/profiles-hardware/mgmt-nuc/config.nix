{
  inputs,
  ...
}:
{
  flake.modules.nixos.profile-hardware-mgmt-nuc =
    {
      config,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        profile-cli
        thunderbolt-network
        k3s-cluster
        inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      ];

      sops.secrets.k3s-token-mgmt.sopsFile = ./secrets.sops.yaml;

      networking = {
        useDHCP = false;
        thunderboltFabric = {
          enable = true;
          interfaces = [
            config.systemd.network.links."20-thunderbolt-port-1".linkConfig.Name
            config.systemd.network.links."20-thunderbolt-port-2".linkConfig.Name
          ];
        };
        firewall = {
          # We switched to cilium Host FW
          enable = false;
          # # cilium does not like this, disable it
          # checkReversePath = false;
          # allowedTCPPorts = [
          #   6443
          #   2379
          #   2380
          #   4240
          #   4244
          # ];
          # allowedUDPPorts = [
          #   8472
          # ];
        };
      };

      # systemd.tmpfiles.rules = [
      #   # "C /opt/cni/bin/host-device - - - - ${pkgs.cni-plugins}/bin/host-device"
      #   # "C /opt/cni/bin/host-local - - - - ${pkgs.cni-plugins}/bin/host-local"
      # ];

      systemd.network = {
        enable = true;
        links = {
          "20-thunderbolt-port-1" = {
            matchConfig = {
              Path = "pci-0000:00:0d.3";
              Driver = "thunderbolt-net";
            };
            linkConfig = {
              Name = "enp0s13f3";
              Alias = "tb1";
              AlternativeName = "tb1";
            };
          };
          "20-thunderbolt-port-2" = {
            matchConfig = {
              Path = "pci-0000:00:0d.2";
              Driver = "thunderbolt-net";
            };
            linkConfig = {
              Name = "enp0s13f2";
              Alias = "tb2";
              AlternativeName = "tb2";
            };
          };
        };
        networks = {
          "20-lan" = {
            matchConfig.Name = "enp86s0";
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
        tokenFile = config.sops.secrets.k3s-token-mgmt.path;
        extraFlags = [
          "--tls-san mgmt.k3s.stinjul.com"
        ];
        # serverAddr = "https://kube.k3s-mgmt.stinjul.com:6443";
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

      systemd.services.k3s.serviceConfig.CPUAffinity = "0-7";

      console.keyMap = "azerty";

      system.stateVersion = "23.11";
    };
}
