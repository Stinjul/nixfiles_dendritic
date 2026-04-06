{
  self,
  inputs,
  ...
}:
{
  config.flake.factory.user =
    {
      username,
    }:
    {
      # collector for user feature additions
      nixos."user-${username}" = { };
      homeManager."user-${username}" = { };

      ### minimal

      nixos."user-${username}-minimal" =
        {
          lib,
          pkgs,
          config,
          ...
        }:
        {
          imports = [
            self.modules.nixos."user-${username}"
          ];

          home-manager.users."${username}" = {
            imports = [
              self.modules.homeManager."user-${username}-minimal"
            ];
          };

          users.users."${username}" = {
            isNormalUser = true;
            home = "/home/${username}";
          };
        };
      homeManager."user-${username}-minimal" =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          imports = [
            self.modules.homeManager."user-${username}"
          ];

          home.username = "${username}";
          home.homeDirectory = "/home/${config.home.username}";
          # All this currently does is add hm to home.packages, but w/e
          programs.home-manager.enable = true;
          home.packages = with pkgs; [ nh ];
        };
      homeManager."user-${username}-minimal-standalone" = {
        imports = [
          self.modules.homeManager."user-${username}-minimal"
        ];
      };

      ### default

      nixos."user-${username}-default" = {
        imports = [ self.modules.nixos."user-${username}-minimal" ];
        home-manager.users."${username}" = {
          imports = [
            self.modules.homeManager."user-${username}-default"
          ];
        };
      };
      homeManager."user-${username}-default" = {
        imports = with inputs.self.modules.homeManager; [
          #  sops-nix
        ];
      };
      homeManager."user-${username}-default-standalone" = {
        imports = [
          self.modules.homeManager."user-${username}-minimal"
          self.modules.homeManager."user-${username}-default"
        ];
      };

      ### cli

      nixos."user-${username}-cli" =
        { lib, pkgs, ... }:
        {
          imports = with inputs.self.modules.nixos; [
            self.modules.nixos."user-${username}-default"
            fish
          ];
          home-manager.users."${username}" = {
            imports = [
              self.modules.homeManager."user-${username}-cli"
            ];
          };
        };
      homeManager."user-${username}-cli" =
        { lib, config, ... }:
        {
          imports = with inputs.self.modules.homeManager; [
            ssh
            fish
            htop
            direnv
          ];
        };
      homeManager."user-${username}-cli-standalone" = {
        imports = [
          self.modules.homeManager."user-${username}-default"
          self.modules.homeManager."user-${username}-cli"
        ];
      };

      ### desktop

      nixos."user-${username}-desktop" = {
        imports = with self.modules.nixos; [
          self.modules.nixos."user-${username}-cli"
        ];
        home-manager.users."${username}" =
          { osConfig, ... }:
          {
            imports = with inputs.self.modules.homeManager; [
              self.modules.homeManager."user-${username}-desktop"
              sops-nix
            ];
            monitors = osConfig.monitors;
          };
      };
      homeManager."user-${username}-desktop" = {
        imports = with inputs.self.modules.homeManager; [
          fonts
          monitors
        ];
      };
      homeManager."user-${username}-desktop-standalone" = {
        imports = with inputs.self.modules.homeManager; [
          self.modules.homeManager."user-${username}-cli"
          self.modules.homeManager."user-${username}-desktop"
          stylix-standalone
        ];
      };
    };
}
