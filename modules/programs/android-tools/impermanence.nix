{
  flake.modules.homeManager.android-tools =
    { pkgs, ... }:
    {
      home.persistence.main = {
        directories = [
          ".android"
        ];
      };
    };
}
