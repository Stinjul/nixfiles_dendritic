{
  inputs,
  ...
}:
{

  flake.modules.nixos.profile-minimal =
    { lib, config, ... }:
    let
      cfg = config.nix.gc.gen-gc;
    in
    {
      options.nix.gc.gen-gc = {
        enable = lib.mkEnableOption "Enable cleaning up older system generations";
        generations = lib.mkOption {
          type = lib.types.str;
          description = ''
            Specify which generations to delete
            Takes the same options as nix-env --delete-generations
          '';
          default = "+5";
        };
      };
      config = lib.mkIf cfg.enable {
        systemd.services = {
          nix-gc.wants = [ "nix-gen-gc.service" ];
          nix-gen-gc = {
            description = "NixOS system generations GC";
            script = "exec ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/system --delete-generations ${cfg.generations}";
            serviceConfig.Type = "oneshot";
            restartIfChanged = false;
          };
        };
      };
    };
}
