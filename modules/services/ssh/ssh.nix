{
  flake.modules.nixos.ssh =
    {
      config,
      lib,
      ...
    }:
    let
      persistPath = lib.optionalString config.environment.persistence-activation.enable config.environment.persistence.main.persistentStoragePath;
    in
    {
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
          StreamLocalBindUnlink = "yes";
        };
        hostKeys = [
          {
            path = "${persistPath}/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
        ];
      };
    };
  flake.modules.homeManager.ssh =
    {
      config,
      options,
      lib,
      ...
    }:
    let
      persistPath = lib.optionalString (
        options.home ? "persistence"
      ) config.home.persistence.main.persistentStoragePath;
    in
    {
      programs.ssh = {
        enable = lib.mkDefault true;
        enableDefaultConfig = false;
        matchBlocks."*" = {
          userKnownHostsFile = "${persistPath}${config.home.homeDirectory}/.ssh/known_hosts";
        };
      };
    };
}
