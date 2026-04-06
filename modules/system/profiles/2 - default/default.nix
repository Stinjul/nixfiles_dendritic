{
  inputs,
  ...
}:
{

  flake.modules.nixos.profile-default =
    { config, lib, ... }:
    let
      persistPath = lib.optionalString config.environment.persistence-activation.enable config.environment.persistence.main.persistentStoragePath;
    in
    {
      imports = with inputs.self.modules.nixos; [
        profile-minimal
        home-manager
        impermanence
        disko
        sops-nix
      ];
      security.sudo.extraConfig = ''
        Defaults lecture = never
      '';
      sops = {
        age.keyFile = "${persistPath}/var/lib/sops-nix/age-key.txt";
      };

    };

  # flake.modules.homeManager.profile-default = {
  #   imports = with inputs.self.modules.homeManager; [
  #     profile-minimal
  #     sops-nix
  #   ];
  # };
}
