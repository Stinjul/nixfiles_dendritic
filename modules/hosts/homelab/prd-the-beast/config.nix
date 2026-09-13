{
  inputs,
  ...
}:
{
  flake.modules.nixos.prd-the-beast =
    {
      config,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        profile-cli
        podman
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      ];

      networking = {
        useDHCP = false;
        hostName = "prd-the-beast";
        firewall = {
          enable = true;
        };
      };

      systemd.network = {
        enable = true;
        networks = {
          "20-lan" = {
            matchConfig.Name = "enp38s0";
            networkConfig = {
              DHCP = "ipv4";
            };
            linkConfig.RequiredForOnline = "routable";
          };
        };
      };

      environment.persistence."/persist" = {
        # I've seen people put logrotate in this but it wants to rename this file while updating it
        # Which doesn't work when it's a bind mount it seems
        # Don't think it's that important anyway, logs get killed after each reboot
        # files = [ "/var/lib/logrotate.status" ];
        directories = [
        ];
      };

      console.keyMap = "azerty";

      system.stateVersion = "25.05";
    };
}
