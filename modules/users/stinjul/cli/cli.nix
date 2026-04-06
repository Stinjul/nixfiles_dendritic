{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.user-stinjul-cli = {
    imports = with inputs.self.modules.nixos; [
      # fish
    ];
  };
  flake.modules.homeManager.user-stinjul-cli =
    {
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        # fish
        # direnv
        starship
        yazi
        htop
        kubectl
      ];
      home.packages = with pkgs; [
        ncdu
        sshfs
        bind
        fd

        unzip
        age
        sops

        wireguard-tools
      ];
    };
}
