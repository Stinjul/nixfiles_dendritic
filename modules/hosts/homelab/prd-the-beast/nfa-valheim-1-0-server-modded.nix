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
      sops.secrets.nfa-valheim-1-0-modded-env = {
        format = "dotenv";
        sopsFile = ./nfa-valheim-1-0-env.env;
      };

      virtualisation.oci-containers.containers."nfa-valheim-1-0-modded" = {
        autoStart = true;
        image = "docker.io/mbround18/valheim:3.8.8";
        volumes = [
          "/mnt/storage/valheim/nfa-valheim-1-0-modded/saves:/home/steam/.config/unity3d/IronGate/Valheim"
          "/mnt/storage/valheim/nfa-valheim-1-0-modded/server:/home/steam/valheim"
          "/mnt/storage/valheim/nfa-valheim-1-0-modded/backups:/home/steam/backups"
        ];
        environment = {
          PORT = "2458";
          NAME = "No Crossplay Allowed - Modded Valheim";
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
          TYPE = "BepInEx";
          GALE_SYNC_CODE = "SKGXIN";
          GALE_SYNC_CONFIGS = "true";
          # From env file:
          # PASSWORD = "";
        };
        environmentFiles = [
          config.sops.secrets.nfa-valheim-1-0-env.path
        ];
        # Some people mention a PORT+2 port?
        # Can't find it in the official docs so no idea, works fine without afaict
        ports = [
          "0.0.0.0:2458:2458/udp"
          "0.0.0.0:2459:2459/udp"
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
        2458
        2459
      ];
    };
}
