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

          # Kaysaar has done it again, a 0.98a-RC8 only special
          # see https://www.ashesofthedomain.info/module/TheoryOfToolbox
          ToT = pkgs.fetchzip {
            url = "https://github.com/Kaysaar/AoTD-Theory-Of-Toolbox/releases/download/major_release/Ashes.of.The.Domain.-.Theory.of.Toolbox.zip";
            sha256 = "sha256-Zda1jNfwyyRy8wlUwrIURSziMGZGHBJJt3j9Nc/XJZE=";
            stripRoot = false;
          };

          postInstall = ''
            # You might be wondering "what the fuck is this random symlink for???"
            # Well... if you're using the nixpkgs version of starsector and the AotD SoP mod you'll notice the game crashes.
            # That's because the nixpkgs version changes where the mods and saves folder are (~/.local/share/starsector)
            # and for reasons I don't really understand the mod in question does some insane path manipulation stuff to locate the saves/common folder
            # which fails, because it assumes the mods and saves folder are in their original location (part of the game root folder)
            # even though the game itself has parameters to override the saves and mods folder's locations
            # it's all documented here, but giving that there's been 0 response so far im assuming this won't be fixed:
            # https://github.com/Kaysaar/Ashes-Of-The-Domain-Seats-of-Power/issues/1
            # this is also the ONLY mod that does this, all other mods find the common folder just fine
            ln -s /home $out/share/starsector/home

            # See ToT comment
            cp -f $ToT/Ashes\ of\ \ The\ Domain\ -\ Theory\ of\ Toolbox/0.98a/starfarer.api.jar $out/share/starsector/
          '';
        }))
        self'.packages.trios
      ];
    }
  );
}
