{
  flake.modules.homeManager.gtk = {
    home.persistence.main = {
      directories = [
        ".config/dconf"
      ];
    };
  };
}
