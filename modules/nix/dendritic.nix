{
  inputs,
  ...
}:
{

  flake-file.inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-file.url = "github:vic/flake-file";
    flake-aspects.url = "github:vic/flake-aspects";
    import-tree.url = "github:vic/import-tree";
    systems.url = "github:nix-systems/default";
  };

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-aspects.flakeModule
    inputs.flake-file.flakeModules.default
  ];

  flake-file.outputs = ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  '';

  systems = import inputs.systems;
}
