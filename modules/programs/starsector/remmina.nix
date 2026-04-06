{ moduleWithSystem, ... }:
{
  flake.modules.homeManager.starsector = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.starsector.overrideAttrs (old: {
          postPatch = old.postPatch + ''
            substituteInPlace starsector.sh \
              --replace-fail "-Xms2048m" "-Xms4096m" \
              --replace-fail "-Xmx2048m" "-Xmx4096m"
          '';
        }))
        self'.packages.trios
      ];
    }
  );
}
