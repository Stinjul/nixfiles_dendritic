{ inputs, ... }:
{
  flake-file.inputs.sysc-greet = {
    url = "github:Nomadcxx/sysc-greet";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.sysc-greet =
    { ... }:
    {
      imports = [ inputs.sysc-greet.nixosModules.default ];
      services.sysc-greet = {
        enable = true;
        compositor = "niri";
      };
    };
}
