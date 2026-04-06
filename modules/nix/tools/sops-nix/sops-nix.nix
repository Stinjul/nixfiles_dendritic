{
  inputs,
  ...
}:
{
  flake.modules.nixos.sops-nix = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
  };
  flake.modules.homeManager.sops-nix = {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
