{
  inputs,
  ...
}:
{
  flake.modules.nixos.zennix = {
    home-manager.users.stinjul =
      { config, ... }:
      {
        sops.secrets = {
          ssh_config = {
            path = "${config.home.homeDirectory}/.ssh/secret_config";
          };
          ssh_key_1 = {
            path = "${config.home.homeDirectory}/.ssh/key_1";
          };
          ssh_key_25_809_123 = {
            # sopsFile = ../global/secrets.yaml;
            path = "${config.home.homeDirectory}/.ssh/yk_25_809_123";
          };
          ssh_key_25_809_126 = {
            # sopsFile = ../global/secrets.yaml;
            path = "${config.home.homeDirectory}/.ssh/yk_25_809_126";
          };
          ssh_key_zennix = {
            path = "${config.home.homeDirectory}/.ssh/yk_25_809_123_zennix";
          };
          ssh_key_deploy = {
            path = "${config.home.homeDirectory}/.ssh/yk_25_809_123_deploy";
          };
        };

        programs.ssh = {
          enable = true;
          # extraConfig = "IdentityFile ${config.sops.secrets.ssh_key_zennix.path}";
          settings = {
            "Match host 172.16.* user deploy" = {
              IdentityFile = config.sops.secrets.ssh_key_deploy.path;
            };
            "Match host 172.16.* user nixos" = {
              IdentityFile = [
                config.sops.secrets.ssh_key_zennix.path
                config.sops.secrets.ssh_key_25_809_123.path
                config.sops.secrets.ssh_key_25_809_126.path
              ];
            };
            "github" = {
              HostName = "github.com";
              IdentityFile = config.sops.secrets.ssh_key_zennix.path;
            };
            "gitlab" = {
              HostName = "gitlab.com";
              IdentityFile = config.sops.secrets.ssh_key_zennix.path;
            };
            "*" = {
              IdentityFile = [
                config.sops.secrets.ssh_key_zennix.path
                config.sops.secrets.ssh_key_25_809_123.path
                config.sops.secrets.ssh_key_25_809_126.path
              ];
            };
          };
          includes = [
            config.sops.secrets.ssh_config.path
          ];
        };
      };
  };
}
