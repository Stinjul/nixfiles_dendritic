{
  inputs,
  ...
}:
{
  flake.modules.nixos.profile-hardware-prd-ms01 = {
    imports = with inputs.self.modules.nixos; [
      user-stinjul-cli
      user-deploy
    ];
    home-manager.users.stinjul = {
      home.stateVersion = "23.11";
    };
  };
}
