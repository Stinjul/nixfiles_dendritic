{
  inputs,
  ...
}:
{
  flake.modules.nixos.prd-the-beast =
    {
      config,
      lib,
      ...
    }:
    {
      sops.secrets.nfa-valheim-1-0-env = {
        format = "dotenv";
        sopsFile = ./nfa-valheim-1-0-env.env;
      };

      virtualisation.oci-containers.containers."nfa-valheim-1-0" = {
        autoStart = true;
        image = "docker.io/mbround18/valheim:3.8.3";
        volumes = [
          "/mnt/storage/valheim/nfa-valheim-1-0/saves:/home/steam/.config/unity3d/IronGate/Valheim"
          "/mnt/storage/valheim/nfa-valheim-1-0/server:/home/steam/valheim"
          "/mnt/storage/valheim/nfa-valheim-1-0/backups:/home/steam/backups"
        ];
        environment = {
          PORT = "2456";
          NAME = "No Crossplay Allowed - Valheim";
          #WORLD = "Debugworld";
          WORLD = "Haustmánuður";
          TZ = "Europe/Brussels";
          PUBLIC = "1";
          AUTO_UPDATE = "1";
          AUTO_UPDATE_SCHEDULE = "0 * * * *";
          AUTO_BACKUP = "1";
          AUTO_BACKUP_PAUSE_WITH_NO_PLAYERS = "1";
          AUTO_BACKUP_SCHEDULE = "*/30 * * * *";
          AUTO_BACKUP_REMOVE_OLD = "1";
          AUTO_BACKUP_DAYS_TO_LIVE = "3";
          AUTO_BACKUP_ON_UPDATE = "1";
          AUTO_BACKUP_ON_SHUTDOWN = "1";
          SAVE_INTERVAL = "300";
          # From env file:
          # PASSWORD = "";
        };
        environmentFiles = [
          config.sops.secrets.nfa-valheim-1-0-env.path
        ];
        # Some people mention a 2458 port?
        # Can't find it in the official docs so no idea, works fine without afaict
        ports = [
          "0.0.0.0:2456:2456/udp"
          "0.0.0.0:2457:2457/udp"
        ];
        # extraOptions = [
        #   "--health-cmd=mc-health"
        #   "--health-start-period=10m"
        #   "--health-interval=5s"
        #   "--health-retries=20"
        #   "--health-timeout=1s"
        #   "--pull=newer"
        # ];
        # podman = {
        #   sdnotify = "healthy";
        # };
      };
      networking.firewall.allowedUDPPorts = [
        2456
        2457
      ];
    };
}
