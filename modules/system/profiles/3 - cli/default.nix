{
  inputs,
  ...
}:
{

  flake.modules.nixos.profile-cli = {
    imports = with inputs.self.modules.nixos; [
      profile-default
      firmware
      ssh
      locale
      polkit
      fish
    ];
  };

  # flake.modules.homeManager.profile-cli = {
  #   imports = with inputs.self.modules.homeManager; [
  #     profile-default
  #     ssh
  #     fish
  #     # starship
  #     # yazi
  #     htop
  #     # k8s
  #     direnv
  #   ];
  # };
}
