{
  flake.modules.homeManager.starsector = {
    home.persistence.main = {
      directories = [
        # {
        #   directory = ".local/share/starsector";
        #   method = "symlink";
        # }
        # ".local/share/starsector"
        ".local/share/starsector/saves"
        ".local/share/starsector/mods"
        ".local/share/starsector/custom_versions"
        ".java/.userPrefs/com/fs/starfarer"
        ".local/share/org.wisp.trios"
      ];
    };
  };
}
