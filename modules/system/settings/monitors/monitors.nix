{ lib, ... }:
let
  localOptions = lib.mkOption {
    type = lib.types.listOf (
      lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            example = "DP-1";
          };
          primary = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          width = lib.mkOption {
            type = lib.types.int;
            example = 1920;
          };
          height = lib.mkOption {
            type = lib.types.int;
            example = 1080;
          };
          refreshRate = lib.mkOption {
            type = lib.types.int;
            default = 60;
          };
          x = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
          y = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
          enabled = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          rotate = lib.mkOption {
            type = lib.types.enum [
              0
              90
              180
              270
            ];
            default = 0;
          };
          flipped = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      }
    );
    default = [ ];
  };

  localAssertions = config: [
    {
      assertion =
        ((lib.length config.monitors) != 0)
        -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
      message = "Exactly one monitor must be set to primary.";
    }
  ];

in
{
  flake.modules.nixos.monitors =
    { config, ... }:
    {
      options.monitors = localOptions;
      config.assertions = localAssertions config;
    };

  flake.modules.homeManager.monitors =
    { config, ... }:
    {
      options.monitors = localOptions;
      config.assertions = localAssertions config;
    };
}
