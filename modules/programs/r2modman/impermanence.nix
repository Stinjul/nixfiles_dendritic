{
  flake.modules.homeManager.r2modman = {
    home.persistence.main = {
      directories = [
        ".config/r2modman"
        ".config/r2modmanPlus-local"
      ];
    };
  };
}
