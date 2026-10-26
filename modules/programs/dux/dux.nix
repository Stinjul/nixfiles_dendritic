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
    { config, ... }:
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
      xdg.configFile =
        let
          version = builtins.concatStringsSep "." (
            builtins.match "([0-9]+)\\.([0-9]+)\\..*" config.programs.dank-material-shell.package.version
          );
        in
        {
          "dms/.firstlaunch".text = "";
          # https://github.com/duxlabs-dev/dux-shell/blob/master/quickshell/Services/ChangelogService.qml#L83
          "dms/.changelog-${version}".text = "${version}\n";
        };
    };
}
