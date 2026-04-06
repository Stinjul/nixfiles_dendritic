{
  inputs,
  ...
}:
{
  flake.modules.nixos.stylix =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
        # inputs.base16.nixosModule
      ];
      stylix = {
        enable = lib.mkDefault true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      };
    };
  # flake.modules.homeManager.stylix =
  #   { lib, ... }:
  #   {
  #     imports = [
  #       inputs.base16.homeManagerModule
  #     ];
  #   };
  flake.modules.homeManager.stylix-standalone =
    { lib, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
        # inputs.self.homeManager.stylix
      ];
      stylix.enable = lib.mkDefault true;
    };
}
