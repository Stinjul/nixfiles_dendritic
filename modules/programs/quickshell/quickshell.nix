{ moduleWithSystem, ... }:
{
  flake-file.inputs.quickshell = {
    url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.homeManager.quickshell = moduleWithSystem (
    { inputs', ... }:
    { ... }:
    {
      programs.quickshell = {
        enable = true;
        package = inputs'.quickshell.packages.quickshell;
        # configs = {
        #   main = ./config;
        # };
        # activeConfig = "main";
        systemd.enable = true;
      };
    }
  );
}
