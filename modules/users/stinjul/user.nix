{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.factory.user { username = "stinjul"; })
    {
      nixos.user-stinjul-default =
        {
          lib,
          config,
          pkgs,
          ...
        }:
        {
          # imports = with inputs.self.modules.nixos; [
          #   fish
          # ];
          sops.secrets = {
            stinjul-password = {
              sopsFile = ./secrets.sops.yaml;
              neededForUsers = true;
            };
          };

          users.users.stinjul = {
            hashedPasswordFile = config.sops.secrets.stinjul-password.path;
            shell = pkgs.fish;
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ./ssh.pub);
            packages = [
              pkgs.kitty.terminfo
            ];
          };

          # security.pam.loginLimits = [
          #   {
          #     domain = "stinjul";
          #     item = "nofile";
          #     type = "-";
          #     value = "1048576";
          #   }
          # ];
        };
      homeManager.user-stinjul-default =
        {
          lib,
          pkgs,
          config,
          ...
        }:
        {
          # imports = with inputs.self.modules.homeManager; [
          #   fish
          # ];
          programs.git.enable = true;

          nix = {
            gc = {
              automatic = true;
              dates = "weekly";
            };
          };
          systemd.user.services.nix-gc.Service.ExecStart = lib.mkForce (
            pkgs.writeShellScript "nix-gc" ''
              ${config.nix.package.out}/bin/nix-env --delete-generations +5
              ${config.nix.package.out}/bin/nix-collect-garbage
              ${config.nix.package.out}/bin/nix-store --optimise
            ''
          );
        };
    }
  ];
}
