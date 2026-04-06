{
  inputs,
  flake-parts-lib,
  ...
}:
{
  # flake.modules.flake.devenv = {
  imports = [
    (flake-parts-lib.importAndPublish "devenv" {
      imports = [
        inputs.devenv.flakeModules.default
      ];
      flake-file.inputs = {
        devenv-root = {
          url = "file+file:///dev/null";
          flake = false;
        };
      };
    })
  ];
}
