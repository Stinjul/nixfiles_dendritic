{
  inputs,
  ...
}:
{
  flake.modules.nixos.prd-the-beast = {
    imports = with inputs.self.modules.nixos; [
      user-stinjul-cli
      user-deploy
    ];
    home-manager.users.stinjul = {
      home.stateVersion = "23.11";
    };
  };
}
