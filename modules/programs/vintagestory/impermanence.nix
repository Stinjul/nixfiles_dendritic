{
  flake.modules.homeManager.remmina = {
    home.persistence.main = {
      directories = [
        ".config/VintagestoryData"
      ];
    };
  };
}
