{
  inputs,
  ...
}:
{
  # flake-file.inputs = {
  #   devenv-root = {
  #     url = "file+file:///dev/null";
  #     flake = false;
  #   };
  # };
  # imports = [ inputs.devenv.flakeModules.default ];
  perSystem =
    { ... }:
    {
      devenv.shells.default =
        { pkgs, ... }:
        {
          devenv.cli.version = "1.11.2";
          imports = with inputs.self.modules.devenv; [
            default
          ];
          packages = with pkgs; [
            sops
            nh
            nix-diff
          ];
        };
    };
}
