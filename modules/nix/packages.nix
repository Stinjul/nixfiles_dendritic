{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];
  perSystem =
    { system, config, ... }:
    {
      # Atleast one of my packages depends on an unfree one
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        # overlays = [
        #   inputs.devenv.overlays.default
        #   #     (final: prev: {
        #   #       local = config.packages;
        #   #     })
        # ];
      };
      pkgsDirectory = ../../pkgs/by-name;
    };
}
