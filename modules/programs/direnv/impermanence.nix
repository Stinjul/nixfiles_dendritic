{
  flake.modules.homeManager.direnv =
    { pkgs, ... }:
    {
      home.persistence.main = {
        directories = [
          ".local/share/direnv"
        ];
      };
    };
}
