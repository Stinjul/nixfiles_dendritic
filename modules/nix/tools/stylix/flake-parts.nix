{
  flake-file.inputs = {
    base16.url = "github:SenchoPens/base16.nix";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.base16.follows = "base16";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
}
