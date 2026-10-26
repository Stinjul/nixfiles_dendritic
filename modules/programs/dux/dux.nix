{ inputs, ... }:
{
  flake-file.inputs = {
    dux = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dux-plugin-registry = {
      url = "github:duxlabs-dev/dux-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.dux =
    { ... }:
    {
      imports = [
        inputs.dux.homeModules.dank-material-shell
        inputs.dux-plugin-registry.homeModules.dms-plugin-registry
      ];
      programs = {
        dank-material-shell = {
          enable = true;
          systemd.enable = true;
        };
      };
    };
}
