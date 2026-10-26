{ inputs, ... }:
{
  flake-file.inputs.dux = {
    url = "github:duxlabs-dev/dux-shell/stable";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.homeManager.dux =
    { ... }:
    {
      imports = [
        inputs.dux.homeModules.dank-material-shell
      ];
      programs = {
        dank-material-shell = {
          enable = true;
          systemd.enable = true;
        };
      };
    };
}
