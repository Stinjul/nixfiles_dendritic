{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    devenv = {
      url = "github:cachix/devenv";
      # url = "github:cachix/devenv/8f875b281ec6600b145c17019e6159ee38bc556d";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
}
