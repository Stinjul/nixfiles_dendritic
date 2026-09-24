{
  inputs,
  ...
}:
{
  flake.modules.nixos.installer-main =
    {
      config,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        user-deploy
        profile-cli
      ];

      environment.persistence-activation.enable = false;
      users.users = {
        nixos.openssh.authorizedKeys.keys = config.users.users.deploy.openssh.authorizedKeys.keys;
        root.openssh.authorizedKeys.keys = config.users.users.deploy.openssh.authorizedKeys.keys;
      };

      console.keyMap = "azerty";
    };
}
