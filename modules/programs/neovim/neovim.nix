{ inputs, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.homeManager.neovim =
    { lib, ... }:
    {
      imports = [ inputs.nixvim.homeModules.nixvim ];
      home.sessionVariables.EDITOR = "nvim";
      programs.nixvim = {
        enable = lib.mkDefault true;
      };
    };
}
