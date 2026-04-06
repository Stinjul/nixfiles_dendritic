{
  flake.modules.nixos.impermanence =
    { config, lib, ... }:
    {
      environment.persistence.main = {
        persistentStoragePath = "/persist";
        directories = [
          "/var/lib/systemd"
          "/var/lib/nixos"
          "/var/log"
        ];
        files = [
          "/etc/machine-id"
          "/etc/adjtime"
          # "/var/lib/sops-nix/age-key.txt"
        ];
      };
      programs.fuse.userAllowOther = true;
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };

  flake.modules.homeManager.impermanence =
    { config, lib, ... }:
    {
      home.persistence.main = {
        persistentStoragePath = "/persist";
        directories = [
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Games"
          "Git"
          ".local/share/nix"
          "Mount"
          ".local/state/wireplumber"
        ];
      };
    };
}
