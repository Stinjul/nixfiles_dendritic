{
  inputs,
  ...
}:
{

  flake.modules.nixos.profile-desktop = {
    imports = with inputs.self.modules.nixos; [
      profile-cli
      monitors
      # stylix
    ];
  };

  # flake.modules.homeManager.profile-desktop = {
  #   imports = with inputs.self.modules.homeManager; [
  #     profile-cli
  #     fonts
  #   ];
  # };
}
