{ moduleWithSystem, ... }:
{
  flake-file.inputs.tuigreet = {
    url = "github:NotAShelf/tuigreet";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.tuigreet = moduleWithSystem (
    { inputs', ... }:
    {
      pkgs,
      config,
      ...
    }:
    let
      configFile = (
        (pkgs.formats.toml { }).generate "truigreet-config.toml" {
          display = {
            show_time = true;
            greeting = config.services.getty.greetingLine;
            align_greeting = "center";
          };
          session = {
            sessions_dirs = [ "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions" ];
          };
        }
      );
    in
    {
      services.greetd = {
        enable = true;
        useTextGreeter = true;
        settings.default_session.command = "${inputs'.tuigreet.packages.tuigreet}/bin/tuigreet --time --issue --asterisks --remember --remember-user-session";
        # settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --issue --asterisks --remember --remember-user-session";
        # "greeter" is the default user, so no need to set
        ## https://github.com/apognu/tuigreet?tab=readme-ov-file#from-nixos
      };
      environment.etc."tuigreet/config.toml".source = configFile;
      # The nixpkgs module happens to create the required folder for the --remember* options with the correct user/group
      ## https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/display-managers/greetd.nix#L146
    }
  );
}
